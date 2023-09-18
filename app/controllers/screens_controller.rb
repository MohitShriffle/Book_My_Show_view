class ScreensController < ApplicationController
  
  before_action :set_screen ,only: [:update, :destroy, :edit] 
  
  def index 
     @screens=Screen.all
  end
  
  def show 
    @theater =Theater.find_by(id: params[:id])
    if @theater
      @screens=@theater.screens
    end
  end

  def new
  end
  
  def create
    screen=Screen.new(screen_params)
      if screen.save
        redirect_to screens_path
      else
        flash[:notice] = 'Screen Not created '
      end
  end
  
  def edit
   
  end
  
  def update
    if @screen.update(screen_params)
      id=@screen.theater.id
      redirect_to screen_path(id)
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
