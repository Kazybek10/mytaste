class MoviesController < BaseController

  def api_search
    results = TmdbService.search(params[:query])
    render json: results
  end

  def api_import
    data = TmdbService.find(params[:tmdb_id])
    render json: data
  end

  private

  def permitted_params
    [:title, :description, :release_year, :director, :genre, :cover_image, :rating]
  end
end
