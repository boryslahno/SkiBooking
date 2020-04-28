class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :contents
      t.belongs_to :user
      t.timestamps
    end
  end
end
