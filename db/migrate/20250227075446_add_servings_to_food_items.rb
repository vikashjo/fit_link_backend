class AddServingsToFoodItems < ActiveRecord::Migration[7.1]
  def change
    add_column :food_items, :servings, :integer, default: 1
  end
end
