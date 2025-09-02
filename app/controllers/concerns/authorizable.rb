module Authorizable
  extend ActiveSupport::Concern

  private

  def correct_user
    resource = current_user.send(controller_name).find_by(id: params[:id])
    redirect_to send("#{controller_name}_path"), alert: 'Not authorized' if resource.nil?
    instance_variable_set("@#{controller_name.singularize}", resource)
  end
end
