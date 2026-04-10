class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_list, :remove_from_list, :update_status]
  before_action :set_recipe, only: [:show, :add_to_list, :remove_from_list, :update_status]

  def index
    @recipes = Recipe.recent
    @recipes = @recipes.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @recipes = pagy(@recipes)
  end

  def show
    @user_item = current_user.user_items.find_by(itemable: @recipe) if user_signed_in?
  end

  def add_to_list
    user_item = current_user.user_items.find_or_initialize_by(itemable: @recipe)
    user_item.status = params[:status] || "want"
    user_item.save
    redirect_to @recipe, notice: "Added to your list."
  end

  def remove_from_list
    current_user.user_items.find_by(itemable: @recipe)&.destroy
    redirect_to @recipe, notice: "Removed from your list."
  end

  def update_status
    user_item = current_user.user_items.find_or_initialize_by(itemable: @recipe)
    user_item.update(status: params[:status], rating: params[:rating])
    redirect_to @recipe
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

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
