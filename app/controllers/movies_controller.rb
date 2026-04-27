class MoviesController < BaseController
  def index
    @movies = Movie.recent
    @movies = @movies.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @movies = @movies.where("genre ILIKE ?", "%#{params[:genre]}%") if params[:genre].present?
    @movies = @movies.where(release_year: params[:year]) if params[:year].present?
    @genres = Movie.where.not(genre: [nil, ""]).distinct.pluck(:genre).sort
    @years  = Movie.where.not(release_year: nil).distinct.pluck(:release_year).sort.reverse
    @pagy, @movies = pagy(@movies)
    render json: @movies
  end

  def api_search
    results = TmdbService.search(params[:query])
    render json: results
  rescue StandardError => e
    Rails.logger.error "TMDB search error: #{e.message}"
    render json: []
  end

  def api_import
    data = TmdbService.find(params[:tmdb_id])
    if data.nil?
      redirect_to movies_path, alert: "Could not fetch movie from TMDB. Please try again."
      return
    end

    movie = Movie.find_or_create_from_tmdb(data.merge(tmdb_id: params[:tmdb_id]))
    redirect_to movie
  rescue StandardError => e
    Rails.logger.error "TMDB import error: #{e.message}"
    redirect_to movies_path, alert: "Something went wrong. Please try again."
  end

  private

  def resource_params
    params.require(:movie).permit(:title, :director, :release_year, :genre, :description, :cover_image)
  end
end
