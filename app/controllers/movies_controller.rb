class MoviesController < BaseController
  def index
    @movies = Movie.recent
    @movies = @movies.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @movies = pagy(@movies)
  end

  def api_search
    render json: TmdbService.search(params[:query])
  end

  def api_import
    data = TmdbService.find(params[:tmdb_id])
    return render json: { error: "Not found" }, status: :not_found unless data

    movie = Movie.find_or_create_from_tmdb(data.merge(tmdb_id: params[:tmdb_id]))
    redirect_to movie
  end

  private

  def resource_params
    params.require(:movie).permit(:title, :director, :release_year, :genre, :description, :cover_image)
  end
end
