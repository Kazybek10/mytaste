require "rails_helper"

RSpec.describe "Books", type: :request do

  let(:user) { create(:user) }
  let(:book) { create(:book, user: user) }

  describe "GET /books" do
    it "returns 200 for guest" do
      get books_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /books/:id" do
    it "returns 200 for guest" do
      get book_path(book)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /books/new" do
    it "redirects guest to login" do
      get new_book_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns 200 for logged in user" do
      sign_in user
      get new_book_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /books" do
    it "redirects guest to login" do
      post books_path, params: { book: { title: "Test" } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "creates a book for logged in user" do
      sign_in user
      expect {
        post books_path, params: { book: attributes_for(:book) }
      }.to change(Book, :count).by(1)
    end
  end

  describe "DELETE /books/:id" do
    it "deletes book for owner" do
      sign_in user
      book_to_delete = create(:book, user: user)
      expect {
        delete book_path(book_to_delete)
      }.to change(Book, :count).by(-1)
    end

    it "redirects guest to login" do
      delete book_path(book)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
