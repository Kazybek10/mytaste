module Paginatable
  extend ActiveSupport::Concern

  private

  def paginate_collection(collection, items_per_page = 2)
    page = params[:page]&.to_i || 1
    total_count = collection.count
    total_pages = (total_count.to_f / items_per_page).ceil
    
    pagy = OpenStruct.new(
      page: page,
      pages: total_pages,
      count: total_count,
      limit: items_per_page,
      prev: page > 1 ? page - 1 : nil,
      next: page < total_pages ? page + 1 : nil
    )
    
    paginated_collection = collection.limit(items_per_page).offset((page - 1) * items_per_page)
    
    [pagy, paginated_collection]
  end
end
