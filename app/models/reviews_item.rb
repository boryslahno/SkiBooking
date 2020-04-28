class ReviewsItem < ApplicationRecord
  belongs_to :review
  belongs_to :item
end
