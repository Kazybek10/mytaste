class RecipesController < BaseController
  def index
    @recipes = Recipe.recent
    @recipes = @recipes.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @recipes = pagy(@recipes)
  end

  def api_search
    render json: ThemealdbService.search(params[:query])
  end

  def api_import
    data = ThemealdbService.find(params[:meal_id])
    return render json: { error: "Not found" }, status: :not_found unless data

    recipe = Recipe.find_or_create_from_api(data.merge(meal_id: params[:meal_id]))
    redirect_to recipe
  end

  private

  def resource_params
    params.require(:recipe).permit(:title, :ingredients, :instructions, :cover_image)
  end
end
