class MoviesController < BaseController
  private

  def permitted_params
    [:title, :description, :release_year, :director]
  end
end
