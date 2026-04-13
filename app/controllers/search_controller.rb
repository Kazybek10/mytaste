class SearchController < ApplicationController
  def index
    query = params[:query].to_s.strip

    if query.length >= 2
      @movies  = Movie.where("title ILIKE ?",  "%#{query}%").limit(4)
      @books   = Book.where("title ILIKE ?",   "%#{query}%").limit(4)
      @recipes = Recipe.where("title ILIKE ?", "%#{query}%").limit(4)
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
