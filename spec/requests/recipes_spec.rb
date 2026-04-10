require "rails_helper"

RSpec.describe "Recipes", type: :request do

  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  describe "GET /recipes" do
    it "returns 200 for guest" do
      get recipes_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /recipes/:id" do
    it "returns 200 for guest" do
      get recipe_path(recipe)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /recipes/new" do
    it "redirects guest to login" do
      get new_recipe_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns 200 for logged in user" do
      sign_in user
      get new_recipe_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /recipes" do
    it "redirects guest to login" do
      post recipes_path, params: { recipe: { title: "Test" } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "creates a recipe for logged in user" do
      sign_in user
      expect {
        post recipes_path, params: { recipe: attributes_for(:recipe) }
      }.to change(Recipe, :count).by(1)
    end
  end

  describe "DELETE /recipes/:id" do
    it "deletes recipe for owner" do
      sign_in user
      recipe_to_delete = create(:recipe, user: user)
      expect {
        delete recipe_path(recipe_to_delete)
      }.to change(Recipe, :count).by(-1)
    end

    it "redirects guest to login" do
      delete recipe_path(recipe)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
