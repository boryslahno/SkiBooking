class UserController < ApplicationController
  skip_before_action :verify_authenticity_token

  #Function display all users
  def index
    user=User.all
    render json:user
  end

  #Adding a new user
  def create
    user=User.new(user_params)
    if User.where("name=?",user['name']).exists? then
      render json:{message:"A user with this name already exist"}
    elsif User.where("email=?",user['email']).exists? then
      render json:{message:"A user with this email already exist"}
    elsif user.save then
      render json:{status:"SUCCESS",message:"Create user",data:user}
    else
      render json:{status:"ERROR",message:"User not create",data:user.errors}
    end
  end

  #Function outputs cities by id
  def show
    user=User.find(params[:id])
    render json:user
  end

  #Function update user attributes
  def update
   user=User.find(params[:id])
   if user.update_attributes(user_params) then
      render json:{status:"SUCCESS",message:"Update user",data:user}
   else
      render json:{status:"ERROR",message:"User not update",data:user.errors}
   end
  end

  private
  def user_params
    params.permit(:name,:email,:city_id)
  end
end
