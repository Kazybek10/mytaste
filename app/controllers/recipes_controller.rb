class RecipesController < BaseController

  def api_search
    results = ThemealdbService.search(params[:query])
    render json: results
  end

  def api_import
    data = ThemealdbService.find(params[:meal_id])
    render json: data
  end

  private

  def permitted_params
    [:title, :ingredients, :instructions, :cover_image, :rating]
  end
end
