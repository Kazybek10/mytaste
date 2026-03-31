class BooksController < BaseController
  private

  def permitted_params
    [:title, :author, :description, :publish_year, :genre, :cover_image, :rating]
  end
end
