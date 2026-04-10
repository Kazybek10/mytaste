class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    items = current_user.user_items

    # Статистика по статусам для каждой категории
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

    # Последние добавленные
    @recent_items = items.includes(:itemable).order(created_at: :desc).limit(6)
  end
end
