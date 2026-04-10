require "rails_helper"

# Request тесты проверяют HTTP запросы — открывается ли страница,
# возвращает ли правильный статус, требует ли авторизацию.

RSpec.describe "Movies", type: :request do

  # let — создаёт переменную которая вычисляется только когда нужна
  let(:user) { create(:user) }
  let(:movie) { create(:movie, user: user) }

  describe "GET /movies" do
    it "returns 200 for guest (public page)" do
      get movies_path
      # expect(response).to have_http_status(200) — страница открылась
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
      # Гость должен быть перенаправлен на страницу логина
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns 200 for logged in user" do
      # sign_in — метод Devise для авторизации в тестах
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
      movie_params = attributes_for(:movie)
      # attributes_for — как build, но возвращает хэш атрибутов без объекта

      expect {
        post movies_path, params: { movie: movie_params }
      }.to change(Movie, :count).by(1)
      # change(...).by(1) — ожидаем что количество фильмов увеличилось на 1
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
