class MoviesController < ApplicationController

  def index
    if(params[:sort]=="title")
      @movies = sort_movies(:title)
    elsif(params[:sort]=="release_date")
      @movies = sort_movies(:release_date)
    else
      @movies = Movie.all
    end
  end

  def show
    @movie = find_movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create! movie_params
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_url
  end

  def edit
    @movie = find_movie
  end

  def update
    @movie = find_movie
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to @movie
  end

  def destroy
    @movie = find_movie
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_url
  end

  private

  def find_movie
    Movie.find(params[:id])
  end

  def movie_params
    params[:movie].permit(:title, :rating, :release_date, :description, :sort)
  end

  def sort_movies (param)
    Movie.order(param)
  end

end

