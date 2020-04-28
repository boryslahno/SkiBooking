class CityController < ApplicationController
  skip_before_action :verify_authenticity_token

  #Function display all cities
  def index
     city=City.all
     render json:city
  end

  #Function for adding a city
  def create
    city=City.new(city_params)
    if City.where("name=?",city['name']).exists? then
      render json:{message:"This city already exists in the database"}
    elsif city.save then
      render json:{status:"SUCCESS",message:"Create city",data:city}
    else
      render json:{status:"ERROR",message:"City not create",data:city.errors}
    end
  end

  #Function outputs cities by id
  def show
    city=City.find(params[:id])
    render json:city
  end

  #Function update city attributes
  def update
     city=City.find(params[:id])
     if city.update_attributes(city_params) then
        render json:{status:"SUCCESS",message:"Update city",data:city}
     else
        render json:{status:"ERROR",message:"City not update",data:city.errors}
     end
  end

  private
  def city_params
     params.permit(:name)
  end
end
