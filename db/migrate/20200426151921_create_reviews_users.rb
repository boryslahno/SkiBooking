class CreateReviewsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews_users do |t|
      t.belongs_to :user
      t.belongs_to :review
      t.timestamps
    end
  end
end
