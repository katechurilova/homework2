class MoviesController < ApplicationController
  before_action :authorize
  helper_method :ratings_params, :all_ratings, :order_where

  def index
    @all_ratings = Movie.all_ratings
    session[:sort_by] = params[:sort_by] if params[:sort_by]
    session[:ratings] = params[:ratings] if params[:ratings]
    @movies = Movie.order_where(ratings_params.keys, "#{session[:sort_by]}" + ' ' + "#{params[:direction]}") 
  end

  def show
    @movie = find_movie
    
    @user = User.where(id:"#{@movie.user_id}") 
    @user_name = User.select("email").where(id:"#{@movie.user_id}").distinct.pluck("email")
      #is movie mine?
      if(@movie.user_id == current_user.id)
        @mine = true
      end
      if(@movie.published)
        @published = "Published " + @movie.updated_at.to_s
      else
        @published = "Draft"
      end
  end

  def new
    @movie = Movie.new
    authorize! :all, @movie
  end

  def create
    @movie = Movie.create! movie_params
    @movie.user_id = current_user.id
    @movie.published = false
    authorize! :all, @movie
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_url
    else
      render 'new'
    end
  end

  def edit
    @movie = find_movie
    authorize! :all, @movie
  end

  def update
    @movie = find_movie
    authorize! :all, @movies
    @movie.update_attributes!(movie_params)
    @movie.update!(published: 'true')
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
    params[:movie].permit(:title, :rating, :release_date, :description, :picture)
  end

  def ratings_params
    session[:ratings] || Hash[@all_ratings.map {|x| [x, "1"]}]
  end  

end

