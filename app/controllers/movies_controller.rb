class MoviesController < ApplicationController
  before_action :authorize
  helper_method :ratings_params, :all_ratings, :order_where, :generate_twin_id

  def index
    can? :read, @movie
    @all_ratings = Movie.all_ratings
    session[:sort_by] = params[:sort_by] if params[:sort_by]
    session[:ratings] = params[:ratings] if params[:ratings]
    @movies = Movie.order_where(ratings_params.keys, "#{session[:sort_by]}" + ' ' + "#{params[:direction]}") 
  end

  def show
    @movie = find_movie
    can? :read, @movie
    @user_name=User.select("email").where(id:"#{@movie.user_id}").distinct.pluck("email")
    @user_admin=User.select("admin").where(id:"#{current_user.id}").distinct.pluck("admin")
      #is movie mine?
      if(@movie.user_id == current_user.id)
        @mine = true
      end
      if(@movie.published)
        @published = "Published "
      else
        @published = "Draft"
      end
  end

  def new
    can? :create, @movie
    @movie = Movie.new
  end

  def create
    can? :create, @movie
    @movie = Movie.create! movie_params
    @movie.user_id = current_user.id
    @movie.published = false
    
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_url
    else
      render 'new'
    end
  end

  def edit
    @movie = find_movie
  end

  def update
    @movie = find_movie
    can? :update, @movie
    @movie.attributes = movie_params
    if @movie.valid?
      if @movie.published?
          Movie.create!Movie.find(@movie.id).attributes.except('id', 'created_at', 'updated_at') 
          @movie.published = false
      end
      @movie.save
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def publish
    @movie = find_movie
    can? :update, @movie
    #@movie_old=Movie.find(twin_id:(@movie.twin_id).to_s, published: 'true')
    #@movie_old.destroy
    @movie.update_column :published, true
    @published = "Published "
    redirect_to @movie
  end

  def destroy
    @movie = find_movie
    can? :destroy, @movie
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_url
  end

  private

  def find_movie
    Movie.find(params[:id])
  end

  def movie_params
    fields = [:title, :rating, :release_date, :description, :twin_id]
    fields += [:published] if current_user.admin?
    params.require(:movie).permit(fields)
  end

  def ratings_params
    session[:ratings] || Hash[@all_ratings.map {|x| [x, "1"]}]
  end  
  
end

