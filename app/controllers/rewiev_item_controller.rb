class RewievItemController < ApplicationController
  skip_before_action :verify_authenticity_token

 #Create review for item
  def create
  ReviewsItem.transaction do
    review=Review.create(contents:review_params[:contents],user_id:review_params[:creator_id])
    reviewItem=ReviewsItem.create(review_id:review.id,item_id:review_params[:item_id])
    check=Item.joins(:bookings).where(bookings:{user_id:review_params[:creator_id],item_id:review_params[:item_id]})
    if check.exists? then
      if reviewItem.errors.any? then
        render json:{status:"ERROR",message:"Review for item not create"}
        raise ActiveRecord::Rollback,'Something went wrong!!!'
      else
        render json:{status:"SUCCESS",message:"Create review for item"}
      end
    else
       render json:{message:"You can not leave review for an item that you have never rented"}
       raise ActiveRecord::Rollback,'Something went wrong!!!'
    end
  end
  end

  #Display
  def show
     reviewsItem=ReviewsItem.all
     render json:reviewsItem
  end

  private
  def review_params
    params.permit(:contents,:item_id,:creator_id,:id)
  end
end
