class CreateCategoryFilters < ActiveRecord::Migration[6.0]
  def change
    create_table :category_filters do |t|
      t.belongs_to :category
      t.belongs_to :filter
      t.belongs_to :item
      t.string :value
      t.timestamps
    end
  end
end
