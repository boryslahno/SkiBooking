class CategoryFilter < ApplicationRecord
  belongs_to :category
  belongs_to :filter
  belongs_to :item
end
