class User < ApplicationRecord
  belongs_to :city
  has_many :items
  has_many :reviews
  has_many :reviews_user
  has_many :bookings
end
