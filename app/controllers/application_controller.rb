class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers
    include Pagy::Backend
end
