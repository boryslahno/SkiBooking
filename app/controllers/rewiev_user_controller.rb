class RewievUserController < ApplicationController
skip_before_action :verify_authenticity_token

def create
ReviewsUser.transaction do
  review=Review.create(contents:review_params[:contents],user_id:review_params[:creator_id])
  reviewUser=ReviewsUser.create(review_id:review.id,user_id:review_params[:user_id])
  check=User.joins(bookings: :item).where(bookings:{user_id:review_params[:creator_id]},items:{user_id:review_params[:user_id]})
  if check.exists? then
    if reviewUser.errors.any? then
      render json:{status:"ERROR",message:"Review for user not create"}
      raise ActiveRecord::Rollback,'Something went wrong!!!'
    else
      render json:{status:"SUCCESS",message:"Create review for user"}
    end
  else
     render json:{message:"You can not leave review for an user that you have never rented"}
     raise ActiveRecord::Rollback,'Something went wrong!!!'
  end
end
end

def show
   reviewsUser=ReviewsUser.all
   #reviewsUser=User.joins(bookings: :item).where(bookings:{user_id:review_params[:creator_id]},items:{user_id:review_params[:user_id]})
   render json:reviewsUser
end

private
def review_params
  params.permit(:contents,:user_id,:creator_id,:id)
end
end
