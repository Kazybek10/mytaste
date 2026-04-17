class BooksController < BaseController
  def index
    @books = Book.recent
    @books = @books.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @books = @books.where("genre ILIKE ?", "%#{params[:genre]}%") if params[:genre].present?
    @books = @books.where(publish_year: params[:year]) if params[:year].present?
    @genres = Book.where.not(genre: [nil, ""]).distinct.pluck(:genre).sort
    @years  = Book.where.not(publish_year: nil).distinct.pluck(:publish_year).sort.reverse
    @pagy, @books = pagy(@books)
  end

  def api_search
    results = OpenLibraryService.search(params[:query])
    render json: results
  rescue StandardError => e
    Rails.logger.error "OpenLibrary search error: #{e.message}"
    render json: []
  end

  def api_import
    data = OpenLibraryService.find(params[:ol_key])
    basic = OpenLibraryService.search(params[:title] || "").first || {}
    merged = (basic || {}).merge(data || {}).merge(ol_key: params[:ol_key])
    book = Book.find_or_create_from_api(merged)
    redirect_to book
  rescue StandardError => e
    Rails.logger.error "OpenLibrary import error: #{e.message}"
    redirect_to books_path, alert: "Something went wrong. Please try again."
  end

  private

  def resource_params
    params.require(:book).permit(:title, :author, :publish_year, :genre, :description, :cover_image)
  end
end
