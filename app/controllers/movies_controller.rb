class MoviesController < ApplicationController
  before_action :authenticate_user!, expect: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    movies_scope = current_user.movies.order(created_at: :desc)
    @pagy, @movies = pagy(movies_scope, items: 2)
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@movie, partial: 'movies/form', locals: { movie: @movie })
      end
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, status: :see_other, notice: 'Movie was successfully deleted.'
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :release_year, :director)
  end

  def correct_user
    @movie = current_user.movies.find_by(id: params[:id])
    redirect_to movies_path, alert: 'Not authorized' if @movie.nil?
  end
end
