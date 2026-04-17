class BaseController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :add_to_list, :remove_from_list, :update_status]
  before_action :set_resource, only: [:show, :edit, :update, :destroy, :add_to_list, :remove_from_list, :update_status]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user_item = current_user.user_items.find_by(itemable: resource) if user_signed_in?
  end

  def new
    set_ivar(resource_class.new)
  end

  def create
    set_ivar(resource_class.new(resource_params))
    if resource.save
      redirect_to resource, notice: "#{resource_class} added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if resource.update(resource_params)
      redirect_to resource, notice: "#{resource_class} updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    redirect_to polymorphic_path(resource_class), notice: "#{resource_class} deleted."
  end

  def add_to_list
    user_item = current_user.user_items.find_or_initialize_by(itemable: resource)
    user_item.status = params[:status] || "want"
    user_item.save
    redirect_to resource, notice: "Added to your list."
  end

  def remove_from_list
    current_user.user_items.find_by(itemable: resource)&.destroy
    redirect_to resource, notice: "Removed from your list."
  end

  def update_status
    user_item = current_user.user_items.find_or_initialize_by(itemable: resource)
    attrs = { status: params[:status] }
    attrs[:rating] = params[:rating] if params[:rating].present?
    attrs[:notes]  = params[:notes]  if params.key?(:notes)
    attrs[:review] = params[:review] if params.key?(:review)
    user_item.update(attrs)
    redirect_to resource, status: :see_other
  end

  private

  def resource_class
    controller_name.classify.constantize
  end

  def resource
    instance_variable_get("@#{controller_name.singularize}")
  end

  def set_ivar(obj)
    instance_variable_set("@#{controller_name.singularize}", obj)
  end

  def set_resource
    set_ivar(resource_class.find(params[:id]))
  end

  def record_not_found
    redirect_to polymorphic_path(resource_class), alert: "#{resource_class} not found."
  end
end
