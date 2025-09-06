class MoviesController < BaseController
  private

  def permitted_params
    [:title, :description, :release_year, :director, :cover_image]
  end
end
