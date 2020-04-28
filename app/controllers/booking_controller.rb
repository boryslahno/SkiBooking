class BookingController < ApplicationController
  skip_before_action :verify_authenticity_token

  #Function display all bookings
  def index
    booking=Booking.all
    render json:booking
  end
  #Adding a new booking
  def create
    booking=Booking.new(booking_params)
    if booking.save then
      render json:{status:"SUCCESS",message:"Create booking",data:booking}
    else
      render json:{status:"ERROR",message:"Booking not create",data:booking.errors}
    end
  end

  #Function outputs booking by id
  def show
    booking=Booking.find(params[:id])
    render json:booking
  end

  #Function update booking attributes
  def update
   booking=Booking.find(params[:id])
   if booking.update_attributes(booking_params) then
      render json:{status:"SUCCESS",message:"Update booking",data:booking}
   else
      render json:{status:"ERROR",message:"Booking not update",data:booking.errors}
   end
  end

  private
  def booking_params
    params.permit(:start,:end,:item_id,:user_id,:price)
  end
end
