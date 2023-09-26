class UsersController < ApplicationController
def index
  @users=User.all
end

def show
end

def new
  @user=User.new
end

def create
  @user = User.new(user_params)
  if @user.save
    UserMailer.welcome_email(@user).deliver_later
  else
    render json: { errors: @user.errors.full_messages}, status: :unprocessable_entity
  end
end

def edit
end

def update
  if @current_user.update(user_params)
    redirect_to profile_path
  else
    render json: @current_user.errors.full_messages
  end
end
private
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
