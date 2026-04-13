class RecipesController < BaseController
  def index
    @recipes = Recipe.recent
    @recipes = @recipes.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @recipes = pagy(@recipes)
  end

  def api_search
    results = ThemealdbService.search(params[:query])
    render json: results
  rescue StandardError => e
    Rails.logger.error "TheMealDB search error: #{e.message}"
    render json: []
  end

  def api_import
    data = ThemealdbService.find(params[:meal_id])
    if data.nil?
      redirect_to recipes_path, alert: "Could not fetch recipe. Please try again."
      return
    end

    recipe = Recipe.find_or_create_from_api(data.merge(meal_id: params[:meal_id]))
    redirect_to recipe
  rescue StandardError => e
    Rails.logger.error "TheMealDB import error: #{e.message}"
    redirect_to recipes_path, alert: "Something went wrong. Please try again."
  end

  private

  def resource_params
    params.require(:recipe).permit(:title, :ingredients, :instructions, :cover_image)
  end
end
