class RecipesController < BaseController
  private

  def permitted_params
    [:title, :ingredients, :instructions, :cover_image]
  end
end
