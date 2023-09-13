class ApplicationController < ActionController::Base
  # protect_from_forgery
   
  include JwtToken
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :current_user

  
  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:user_name,:type])
  end
  
  
  def check_owner
    return render json: {message: "User not an Owner"} unless current_user.owner?
  end
  
  def check_customer
    return render json: {message: "User not an Customer"} unless current_user.customer?
  end
  
  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
  
  def handle_exception
    render json: { error: 'ID not found' }
  end
end
