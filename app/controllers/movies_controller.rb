class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :add_to_list, :remove_from_list, :update_status]
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :add_to_list, :remove_from_list, :update_status]

  def index
    @movies = Movie.recent
    @movies = @movies.where("title ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @pagy, @movies = pagy(@movies)
  end

  def show
    @user_item = current_user.user_items.find_by(itemable: @movie) if user_signed_in?
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "Movie deleted."
  end

  # GET /movies/search?query=inception — поиск по TMDB
  def search
    @results = TmdbService.search(params[:query])
    render json: @results
  end

  # POST /movies/:id/add — добавить фильм в список пользователя
  def add_to_list
    user_item = current_user.user_items.find_or_initialize_by(itemable: @movie)
    user_item.status = params[:status] || "want"
    user_item.save
    redirect_to @movie, notice: "Added to your list."
  end

  # DELETE /movies/:id/remove — убрать из списка
  def remove_from_list
    current_user.user_items.find_by(itemable: @movie)&.destroy
    redirect_to @movie, notice: "Removed from your list."
  end

  # PATCH /movies/:id/status — обновить статус или рейтинг
  def update_status
    user_item = current_user.user_items.find_or_initialize_by(itemable: @movie)
    attrs = { status: params[:status] }
    attrs[:rating] = params[:rating] if params[:rating].present?
    user_item.update(attrs)
    redirect_to @movie, status: :see_other
  end

  # GET /movies/api_search?query=... — поиск по TMDB (JSON)
  def api_search
    render json: TmdbService.search(params[:query])
  end

  # GET /movies/api_import?tmdb_id=... — импорт фильма из TMDB
  def api_import
    data = TmdbService.find(params[:tmdb_id])
    return render json: { error: "Not found" }, status: :not_found unless data

    movie = Movie.find_or_create_from_tmdb(data.merge(tmdb_id: params[:tmdb_id]))
    redirect_to movie
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :director, :release_year, :genre, :description, :cover_image)
  end
end
