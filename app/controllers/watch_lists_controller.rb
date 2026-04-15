class WatchListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_watch_list, only: [:update, :destroy]

  def create
    @watch_list = current_user.watch_lists.build(watch_list_params)
    if @watch_list.save
      redirect_to profile_path, notice: "List created."
    else
      redirect_to profile_path, alert: @watch_list.errors.full_messages.first
    end
  end

  def update
    if @watch_list.update(watch_list_params)
      redirect_to profile_path, notice: "List renamed."
    else
      redirect_to profile_path, alert: @watch_list.errors.full_messages.first
    end
  end

  def destroy
    @watch_list.destroy
    redirect_to profile_path, notice: "List deleted."
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      current_user.watch_lists.where(id: id).update_all(position: index)
    end
    head :ok
  end

  private

  def set_watch_list
    @watch_list = current_user.watch_lists.find(params[:id])
  end

  def watch_list_params
    params.require(:watch_list).permit(:name)
  end
end
