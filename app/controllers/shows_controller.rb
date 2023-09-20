class ShowsController < ApplicationController
  before_action :set_show ,only: [:show,:update,:destroy]
  def index
    movie=Movie.find(params[:movie_id])
    @shows=movie.shows 
  end
  
  def show
    #  @screen=Screen.find(params[:screen_id])
  end
  def new
    @show=Show.new
    @movie=Movie.all
    @screen=Screen.find(params[:screen_id])
  end
  def create
    show = Show.new(show_params)
    if show.save
      redirect_to show_path(show)
    else
      render json: show.errors.full_messages
    end
  end
  
  def update
    if @show.update(show_params)
      render json: @show
    else
      @show.errors.full_messages
    end
  end
  
  def destroy
    if @show.destroy
      rander json: {message:"Show Deleted Succesfull"}
    end
  end
  private
  
  def set_show
    @show=Show.find(params[:id])
  end
  
  def show_params
    params.require(:show).permit(
      :start_time,
      :end_time,
      :movie_id,
      :screen_id
    )
  end
end
