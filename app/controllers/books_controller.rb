class BooksController < BaseController
  def index
    @books = Book.recent
    @books = @books.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @books = pagy(@books)
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

  def resource_params
    params.require(:book).permit(:title, :author, :publish_year, :genre, :description, :cover_image)
  end
end
