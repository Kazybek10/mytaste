class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      books_scope = current_user.books.order(created_at: :desc)
    else
      books_scope = Book.all.order(created_at: :desc)
    end
    @pagy, @books = pagy(books_scope, items: 2)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@book, partial: 'books/form', locals: { book: @book })
      end
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Book was successfully deleted.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :publish_year)
  end

  def correct_user
    @book = current_user.books.find_by(id: params[:id])
    redirect_to books_path, alert: 'Not authorized' if @book.nil?
  end
end
