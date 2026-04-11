class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :add_to_list, :remove_from_list, :update_status]
  before_action :set_book, only: [:show, :edit, :update, :destroy, :add_to_list, :remove_from_list, :update_status]

  def index
    @books = Book.recent
    @books = @books.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @books = pagy(@books)
  end

  def show
    @user_item = current_user.user_items.find_by(itemable: @book) if user_signed_in?
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "Book added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book deleted."
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
    attrs = { status: params[:status] }
    attrs[:rating] = params[:rating] if params[:rating].present?
    user_item.update(attrs)
    redirect_to @book, status: :see_other
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

  def book_params
    params.require(:book).permit(:title, :author, :publish_year, :genre, :description, :cover_image)
  end
end
