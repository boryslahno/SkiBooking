class CategoryController < ApplicationController
  skip_before_action :verify_authenticity_token

  #Function display all users
  def index
    category=Category.all
    render json:category
  end

  #Adding a new categoty
  def create
    category=Category.new(category_params)
    if Category.where("name=?",category['name']).exists? then
      render json:{message:"This category already exists in database"}
    elsif category.save then
      render json:{status:"SUCCESS",message:"Create category",data:category}
    else
      render json:{status:"ERROR",message:"Category not create",data:category.errors}
    end
  end

  #Function outputs cities by id
  def show
    category=Category.find(params[:id])
    render json:category
  end

  #Function update user attributes
  def update
    category=Category.find(params[:id])
    if category.update_attributes(category_params) then
      render json:{status:"SUCCESS",message:"Update category",data:category}
      else
      render json:{status:"ERROR",message:"Category not update",data:category.errors}
    end
  end

  private
  def category_params
     params.permit(:name)
  end
end
