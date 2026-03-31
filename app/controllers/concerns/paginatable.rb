module Paginatable
  extend ActiveSupport::Concern

  included do
    include Pagy::Backend
  end
end
