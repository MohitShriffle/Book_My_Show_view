class ApplicationController < ActionController::Base
  # protect_from_forgery
   
  include JwtToken
 
  before_action :authenticate_user!
  # before_action :check_customer, except: [:login]
  # before_action :check_owner, except: [:login]
  
  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  # def login 
  #   @user = User.find_by(email: params[:email])
  #   if @user&.authenticate(params[:password])
  #     # session[:current_user]
  #     token= jwt_encode({user_id: @user.id})
      
  #     # redirect_to movies_path
  #     # render json: {message: "UserLogin Succesfull"}
  #     render json: {token:}
  #   else
  #       render json: { error: 'Unauthorized' }, status: :unauthorized
  #   end
  # end

  # def logout
  #   session.delete(:current_user)
  #   @current_user =nil
  # end

  # private
  # def authenticate_user
  #   header = request.headers['Authorization']
  #   header = header.split(' ').last if header  
  #   begin
  #     decoded = jwt_decode(header)
  #     @current_user = User.find(decoded[:user_id])
  #   rescue JWT::DecodeError => e  
  #     render json: { error: e.message }, status: :unauthorized 
  #   end
  # end
  
  # def check_owner
  #   return render json: {message: "User not an Owner"} unless @current_user.owner?
  # end
  
  # def check_customer
  #   return render json: {message: "User not an Customer"} unless @current_user.customer?
  # end
  
  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
  
  def handle_exception
    render json: { error: 'ID not found' }
  end
end
