class SearchController < ApplicationController
  def index
    query = params[:query].to_s.strip

    if query.length >= 2
      base_movies  = user_signed_in? ? current_user.movies  : Movie.all
      base_books   = user_signed_in? ? current_user.books   : Book.all
      base_recipes = user_signed_in? ? current_user.recipes : Recipe.all

      @movies  = base_movies.where("title ILIKE ?",  "%#{query}%").limit(4)
      @books   = base_books.where("title ILIKE ?",   "%#{query}%").limit(4)
      @recipes = base_recipes.where("title ILIKE ?", "%#{query}%").limit(4)
    else
      @movies = @books = @recipes = []
    end

    render json: {
      movies:  @movies.map  { |m| { title: m.title, url: movie_path(m)  } },
      books:   @books.map   { |b| { title: b.title, url: book_path(b)   } },
      recipes: @recipes.map { |r| { title: r.title, url: recipe_path(r) } }
    }
  end
end
