class FilterController < ApplicationController
  skip_before_action :verify_authenticity_token

  #Function display all filters
  def index
    filter=Filter.all
    render json:filter
  end

  #Adding a new filters
  def create
    filter=Filter.new(filter_params)
    if Filter.where("name=?",filter['name']).exists? then
      render json:{message:"A filter with this name already exist"}
    elsif filter.save then
      render json:{status:"SUCCESS",message:"Create filter",data:filter}
    else
      render json:{status:"ERROR",message:"Filter not create",data:filter.errors}
    end
  end

  #Function outputs cities by id
  def show
    filter=Filter.find(params[:id])
    render json:filter
  end

  #Function update user attributes
  def update
   filter=Filter.find(params[:id])
   if filter.update_attributes(filter_params) then
      render json:{status:"SUCCESS",message:"Update filter",data:filter}
   else
      render json:{status:"ERROR",message:"Filter not update",data:filter.errors}
   end
  end

  private
  def filter_params
    params.permit(:name)
  end
end
