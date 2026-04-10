class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_list, :remove_from_list, :update_status]
  before_action :set_book, only: [:show, :add_to_list, :remove_from_list, :update_status]

  def index
    @books = Book.recent
    @books = @books.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @books = pagy(@books)
  end

  def show
    @user_item = current_user.user_items.find_by(itemable: @book) if user_signed_in?
  end

  def add_to_list
    user_item = current_user.user_items.find_or_initialize_by(itemable: @book)
    user_item.status = params[:status] || "want"
    user_item.save
    redirect_to @book, notice: "Added to your list."
  end

  def remove_from_list
    current_user.user_items.find_by(itemable: @book)&.destroy
    redirect_to @book, notice: "Removed from your list."
  end

  def update_status
    user_item = current_user.user_items.find_or_initialize_by(itemable: @book)
    user_item.update(status: params[:status], rating: params[:rating])
    redirect_to @book
  end

  def api_search
    render json: OpenLibraryService.search(params[:query])
  end

  def api_import
    data = OpenLibraryService.find(params[:ol_key])
    basic = OpenLibraryService.search(params[:title] || "").first || {}
    merged = (basic || {}).merge(data || {}).merge(ol_key: params[:ol_key])
    book = Book.find_or_create_from_api(merged)
    redirect_to book
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
