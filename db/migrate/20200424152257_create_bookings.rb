class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :item
      t.belongs_to :user
      t.integer :price
      t.text :start
      t.text :end
      t.timestamps
    end
  end
end
