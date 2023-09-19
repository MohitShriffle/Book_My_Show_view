class ScreensController < ApplicationController
  
  before_action :set_screen ,only: [:update, :destroy, :edit,:show] 
  
  def index
    theater=Theater.find_by(id: params[:theater_id])
    @screens=theater.screens
  end
  
  def show 
  end
  
  def new
    @screen=Screen.new
    @theater=Theater.find(params[:theater_id])
  end
  
  def create
    screen=Screen.new(screen_params)
    if screen.save
      redirect_to theater_screens_path(screen.theater_id)
    else
      flash[:notice] = 'Screen Not created '
    end
  end
  
  def edit
    
  end
  
  def update
    if @screen.update(screen_params)
      redirect_to screen_path(@screen)
    else
      flash[:notice] = 'Screen Not Updated '
    end
  end
  
  def destroy
    debugger
    if @screen.destroy
      debugger
      render json: {message: "Screen Deleted Succusfull"}
    else
      render json: @screen.errors.full_messages
    end
  end
  
  def set_screen
    @screen =Screen.find(params[:id])
  end
  
  def screen_params 
    params.require(:screen).permit(
      :screen_name,
      :capacity,
      :theater_id
    )
  end
end
