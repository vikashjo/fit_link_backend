class CreateFoodEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :food_entries do |t|
      t.integer :quantity, precision: 10, scale: 2, null: false
      t.references :food_item, null: false, foreign_key: true
      t.string :unit, null: false
      t.integer :servings, default: 1
      t.references :meal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
