class ReviewController < ApplicationController
  skip_before_action :verify_authenticity_token

  #Display
  def show
   result=Review.all
   render json:result
  end

  #Displaying all reviews of all items from a specific user
  def showAllRewiewsToAllItems
   reviewsAllItem=Item.joins(reviews_item: :review).select('items.id,items.name,items.price,reviews.contents').where(items:{user_id:review_params[:user_id]})
   render json:reviewsAllItem
  end

  private
  def review_params
     params.permit(:user_id)
  end
end
