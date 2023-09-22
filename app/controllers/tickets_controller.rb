class TicketsController < ApplicationController
  before_action :find_show, only: [:new, :create]

  
   def index  
    @booking_history=current_user.tickets
    if @booking_history.presence
      
    else
      render json: {message: "booking history not available for you"}
    end
  end

  def search_tickets_by_id
  end

  def search_tickets
    id=params[:unique_id]
    unless id.presence
      render json: {message: "please give write information"}
    end
    ticket=Ticket.find_by(unique_id: params[:unique_id])
    if ticket.presence
      render json: ticket
    else
      render json: {errors: "No ticket prensent for your id"}
    end
  end
  
  def new
    @ticket = Ticket.new
  end
  
  def create
    @ticket = @show.tickets.new(ticket_params)
      @ticket.user = current_user
      if @ticket.valid?
        ActiveRecord::Base.transaction do
        @ticket.save
        @show.screen.update(capacity: @show.screen.capacity)
        redirect_to tickets_path
        end
      else
        redirect_to tickets_path
      end
    
  end
  
  def ticket_params
    params.require(:ticket).permit(:ticket_purchased)
  end

  def find_show
    @show = Show.find_by(id: params[:show_id])
    redirect_to tickets_path and return unless @show
  end

end

