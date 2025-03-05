class RemoveColumnsFromFoodItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :food_items, :quantity, :decimal
    remove_column :food_items, :unit, :string
    remove_column :food_items, :servings, :integer
    remove_reference :food_items, :meal, null: false, foreign_key: true
  end
end
