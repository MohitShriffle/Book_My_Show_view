class TheatersController < ApplicationController
  before_action :set_value ,only: [:update, :destroy,:show,:edit]
  load_and_authorize_resource
  
  def index
    @theaters =@current_user.theaters.paginate(:page => params[:page], :per_page => 2)
    # @theaters=@current_user.theaters
  end
  
  def show
    
  end
  def new
 
  end
  def create
    theater=@current_user.theaters.new(theater_params)
    if theater.save
      redirect_to theaters_path
    else
      render json:{errors: theater.errors.full_messages}
    end
  end
  
  def edit
  end
  
  def update
    if @theater.update(theater_params)
      redirect_to theaters_path(@theater)
    else
      @theater.errors.full_messages
    end
  end
  
  def destroy
    if @theater.destroy
      redirect_to theaters_path
    else
      render json: @theater.errors.full_messages
    end
  end
  private
  def theater_params
    params.require(:theater).permit(:name, :location, screens_attributes: [:screen_name, :capacity])
  end
  
  def set_value
    @theater=@current_user.theaters.find(params[:id])
  end
  
end
