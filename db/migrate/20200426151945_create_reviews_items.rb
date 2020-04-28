class CreateReviewsItems < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews_items do |t|
      t.belongs_to :item
      t.belongs_to :review
      t.timestamps
    end
  end
end
