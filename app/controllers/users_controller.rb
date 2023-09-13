class UsersController < ApplicationController
# skip_before_action :authenticate_user, except: [:show, :update]  


def index
  if current_user.type=="Owner"
    redirect_to movies_path
  # elsif current_user.type=="Customer"
  #   redirect_to movies_path
  end
end
def show
  render json: @current_user
end

def login;
end

# def signup;
# end
def new
  @user=User.new
end
def create
  @user = User.new(user_params)
  debugger
  if @user.save 
    UserMailer.with(user: @user).welcome_email.deliver_later
  else
    render json: { errors: @user.errors.full_messages}, status: :unprocessable_entity   
  end 
end
def edit 
  
end
def update
  if @current_user.update(user_params)
    render json: @current_user
  else
    render json: @current_user.errors.full_messages
  end
end

def user_params
  params.require(:user).permit(
    :name,
    :user_name,
    :email,
    :password,
    :password_confirmation,
    :image,
    :type
  )
end
end
