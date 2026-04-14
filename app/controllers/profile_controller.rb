class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    items = current_user.user_items.includes(:itemable)

    @stats = {
      movies: {
        completed: items.where(itemable_type: "Movie", status: "completed").count,
        watching:  items.where(itemable_type: "Movie", status: "watching").count,
        want:      items.where(itemable_type: "Movie", status: "want").count
      },
      books: {
        completed: items.where(itemable_type: "Book", status: "completed").count,
        watching:  items.where(itemable_type: "Book", status: "watching").count,
        want:      items.where(itemable_type: "Book", status: "want").count
      },
      recipes: {
        completed: items.where(itemable_type: "Recipe", status: "completed").count,
        watching:  items.where(itemable_type: "Recipe", status: "watching").count,
        want:      items.where(itemable_type: "Recipe", status: "want").count
      }
    }

    @lists = {
      want:      items.where(status: "want").order(created_at: :desc),
      watching:  items.where(status: "watching").order(created_at: :desc),
      completed: items.where(status: "completed").order(created_at: :desc)
    }

    @watch_lists = current_user.watch_lists.includes(user_items: :itemable)
  end

  def edit
  end

  def update
    if current_user.update_with_password(profile_params)
      bypass_sign_in(current_user)
      redirect_to profile_path, notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password, :avatar)
  end
end
