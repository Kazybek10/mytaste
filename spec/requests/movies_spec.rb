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
end
