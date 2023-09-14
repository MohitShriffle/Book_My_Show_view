class MoviesController < ApplicationController
  
  before_action :check_owner, except: [:index, :search_movie]
  before_action :set_value, only:[:update, :destroy, :show,:edit]

  def index
    @movies = Movie.paginate(:page => params[:page], :per_page => 10)
    # render json: @movie
    # @movies =Movie.all
  end

  def show
    
  end

  def new
   
  end
  def create
    movie=Movie.new(movie_params)
    if movie.save
      render json: movie
    else
      movie.errors.full_messages
    end
  end
  def edit
  end
  def update
    if @movie.update(movie_params) 
      debugger
      redirect_to movie_url(@movie)
    else
      render json: @movie.errors.full_messages
    end
  end
  
  def destroy
     if @movie.destroy
      redirect_to movie_url(@movie)
     else
      @movie.errors.full_messages
     end
  
  end
  
  def search_movie
    name = params[:name]
    if name.blank?
      return render json: { error: "Name field can't be blank" }, status: :bad_request
    end
    movies = Movie.where("name ILIKE ?", "%#{name}%")
    if movies.empty?
      return render json: { message: "Movie not found" }, status: :not_found
    end
    render json: movies
  end
  
  private
  
  def movie_params
    params.permit(:name, :poster)
  end
  
  def set_value
    @movie=Movie.find(params[:id])
  end
end

