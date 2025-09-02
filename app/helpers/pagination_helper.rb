module PaginationHelper
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
  
  def pagination_nav(pagy, path_method)
    return unless pagy && pagy.pages > 1
    
    content_tag :div, class: "pagy-nav" do
      links = []
      
      # Previous button
      if pagy.prev
        links << link_to("Previous", send(path_method, page: pagy.prev), class: "page prev")
      end
      
      # Page numbers
      (1..pagy.pages).each do |page_num|
        if page_num == pagy.page
          links << content_tag(:span, page_num, class: "page active")
        else
          links << link_to(page_num, send(path_method, page: page_num), class: "page")
        end
      end
      
      # Next button
      if pagy.next
        links << link_to("Next", send(path_method, page: pagy.next), class: "page next")
      end
      
      links.join.html_safe
    end
  end
end
