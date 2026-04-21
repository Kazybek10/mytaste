require "rails_helper"

RSpec.describe "Movies", type: :request do
  let(:user) { create(:user) }
  let(:movie) { create(:movie, user: user) }

  describe "GET /movies" do
    it "returns 200 for guest" do
      get movies_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /movies/:id" do
    it "returns 200 for guest" do
      get movie_path(movie)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /movies/new" do
    it "redirects guest to login" do
      get new_movie_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns 200 for logged in user" do
      sign_in user
      get new_movie_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /movies" do
    it "redirects guest to login" do
      post movies_path, params: { movie: { title: "Test" } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "creates a movie for logged in user" do
      sign_in user
      expect {
        post movies_path, params: { movie: attributes_for(:movie) }
      }.to change(Movie, :count).by(1)
    end
  end

  describe "DELETE /movies/:id" do
    it "deletes movie for owner" do
      sign_in user
      movie_to_delete = create(:movie, user: user)
      expect {
        delete movie_path(movie_to_delete)
      }.to change(Movie, :count).by(-1)
    end

    it "redirects guest to login" do
      delete movie_path(movie)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST /movies/:id/add_to_list" do
    it "redirects guest to login" do
      post add_to_list_movie_path(movie), params: { status: "want" }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "creates a user_item for logged in user" do
      sign_in user
      expect {
        post add_to_list_movie_path(movie), params: { status: "want" }
      }.to change(UserItem, :count).by(1)
    end
  end

  describe "PATCH /movies/:id/update_status" do
    it "redirects guest to login" do
      patch update_status_movie_path(movie), params: { status: "watching" }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "updates user_item status" do
      sign_in user
      create(:user_item, user: user, itemable: movie, status: "want")
      patch update_status_movie_path(movie), params: { status: "completed" }
      expect(user.user_items.find_by(itemable: movie).status).to eq("completed")
    end

    it "saves rating when provided" do
      sign_in user
      create(:user_item, user: user, itemable: movie, status: "completed")
      patch update_status_movie_path(movie), params: { status: "completed", rating: 4 }
      expect(user.user_items.find_by(itemable: movie).rating).to eq(4)
    end
  end

  describe "DELETE /movies/:id/remove_from_list" do
    it "removes user_item" do
      sign_in user
      create(:user_item, user: user, itemable: movie)
      expect {
        delete remove_from_list_movie_path(movie)
      }.to change(UserItem, :count).by(-1)
    end
  end
end
