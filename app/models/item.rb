class Item < ApplicationRecord
  belongs_to :user
  has_many :category_filters
  has_many :reviews_item
  has_many :bookings
end
