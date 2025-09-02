class BooksController < BaseController
  private

  def permitted_params
    [:title, :author, :description, :publish_year]
  end
end
