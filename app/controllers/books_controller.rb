class BooksController < BaseController

  def api_search
    results = OpenLibraryService.search(params[:query])
    render json: results
  end

  def api_import
    data = OpenLibraryService.find(params[:ol_key])
    render json: data
  end

  private

  def permitted_params
    [:title, :author, :description, :publish_year, :genre, :cover_image, :rating]
  end
end
