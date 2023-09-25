class TicketsController < ApplicationController
  before_action :find_show, only: [:new, :create]
  before_action :set_ticket, only:[:show,:destroy]

   def index
    @booking_history=current_user.tickets
    if @booking_history.presence

    else
      flash[:notice]="Curruntly we dont have your booking history"
    end
  end
  
  def show
  end

  def search_tickets_by_id
  end

  def search_tickets
    id=params[:unique_id]
     
    unless id.presence
      flash.now[:status_msg] = "please give write information"
    end
    ticket=Ticket.find_by(unique_id: params[:unique_id])
   
    if ticket.presence
      redirect_to ticket_path(ticket)
    else
      flash.now[:status_msg] = "please give write information"

    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = @show.tickets.new(ticket_params)
    @ticket.user = current_user
    if @ticket.valid?
      if (@show.screen.capacity > params[:ticket][:ticket_purchased].to_i)
        ActiveRecord::Base.transaction do
          @ticket.save
          @show.screen.update(capacity: @show.screen.capacity-params[:ticket][:ticket_purchased].to_i)
          redirect_to tickets_path
        end
      else
        flash[:notice] = 'Seat Not available'
      end
    else
      redirect_to tickets_path
    end
  end
  def destroy
    if @ticket.destroy
      redirect_to movies_path    
    end  
  end

  private
  def ticket_params
    params.require(:ticket).permit(:ticket_purchased)
  end

  def find_show
    @show = Show.find_by(id: params[:show_id])
    redirect_to tickets_path and return unless @show
  end
  
  def set_ticket
    @ticket=Ticket.find(params[:id])
  end

end
