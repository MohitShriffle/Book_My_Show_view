class ShowsController < ApplicationController
  before_action :set_show ,only: [:show,:update,:destroy]
  before_action :find_screen, only: [:create,:new]
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

  end
  def create
    @show = @screen.build_show(show_params)

    if @show.save
      redirect_to show_path(@show)
    else
      render json: @show.errors.full_messages
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
      :movie_id
    )
  end
  def find_screen
    @screen=Screen.find_by(id: params[:screen_id])
    redirect_to tickets_path and return unless @screen
  end
end
