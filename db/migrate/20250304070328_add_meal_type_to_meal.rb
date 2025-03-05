class AddMealTypeToMeal < ActiveRecord::Migration[7.1]
  def change
    add_reference :meals, :meal_type, null: false, foreign_key: true
  end
end
