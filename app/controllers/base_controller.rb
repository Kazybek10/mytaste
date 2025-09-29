class BaseController < ApplicationController
  include Paginatable
  include Authorizable

  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      collection_scope = current_user.send(controller_name).recent
    else
      collection_scope = controller_name.classify.constantize.recent
    end
    
    if params[:query].present?
      collection_scope = collection_scope.where("title ILIKE ?", "%#{params[:query]}%")
    end
    
    pagy_result, paginated_collection = paginate_collection(collection_scope, 5)
    @pagy = pagy_result
    instance_variable_set("@#{controller_name}", paginated_collection)
  end

  def show
  end

  def new
    instance_variable_set("@#{controller_name.singularize}", controller_name.classify.constantize.new)
  end

  def create
    resource = current_user.send(controller_name).build(resource_params)
    
    if resource.save
      flash[:notice] = "#{controller_name.classify} was successfully created."
      redirect_to resource
    else
      instance_variable_set("@#{controller_name.singularize}", resource)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(resource, partial: "#{controller_name}/form", locals: { controller_name.singularize.to_sym => resource })
      end
    end
  end

  def update
    if resource.update(resource_params)
      flash[:notice] = "#{controller_name.classify} was successfully updated."
      redirect_to send("#{controller_name}_path")
    else
      instance_variable_set("@#{controller_name.singularize}", resource)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    redirect_to send("#{controller_name}_path"), notice: "#{controller_name.classify} was successfully deleted."
  end

  private

  def set_resource
    instance_variable_set("@#{controller_name.singularize}", controller_name.classify.constantize.find(params[:id]))
  end

  def resource
    instance_variable_get("@#{controller_name.singularize}")
  end

  def resource_params
    params.require(controller_name.singularize.to_sym).permit(*permitted_params)
  end

  def permitted_params
    raise NotImplementedError, "Subclasses must implement permitted_params method"
  end
end
