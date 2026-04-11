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
  end
end
