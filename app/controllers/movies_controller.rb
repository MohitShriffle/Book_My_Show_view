class MoviesController < ApplicationController

  # before_action :set_value, only:[:update, :destroy,:edit]
  load_and_authorize_resource

  def index
    # @movies = Movie.paginate(:page => params[:page], :per_page => 10)
    # render json: @movie
     @movies =Movie.all
  end

  def show
  end
  def new
    @movie = Movie.new
    authorize! :create, @movie
    render :new
  end

  def create
    movie=Movie.new(movie_params)
    if movie.save
      redirect_to movie_path(movie)
    else
      movie.errors.full_messages
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to movie_url(@movie)
    else
      render json: @movie.errors.full_messages
    end
  end

  def destroy
    if @movie.destroy
      redirect_to movies_path
    else
      @movie.errors.full_messages
    end
  end
  def search_movie_by_name

  end
  def search_movie
    name = params[:name]

    if name.blank?
      flash[:notice] = 'Name cannot be blank'
    else
      movies = Movie.where("name LIKE ?", "%#{name}%")

      if movies.empty?
        flash[:notice] = 'Movie Not Found'
      else
        # Assuming you want to redirect to the first found movie if there are multiple matches
        redirect_to movie_path(movies.first)
        return
      end
    end

    # Redirect back to the previous page (or any other desired page)
    redirect_back fallback_location: root_path
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :release_date, :poster)
  end

  def set_value
    @movie=Movie.find(params[:id])
  end
end
