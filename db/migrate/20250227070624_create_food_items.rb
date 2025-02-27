class CreateFoodItems < ActiveRecord::Migration[7.1]
  def change
    create_table :food_items do |t|
      t.references :meal, null: false, foreign_key: true # Links food item to a meal
      t.string :name, null: false                        # Name of the food item
      t.decimal :quantity, precision: 10, scale: 2, null: false # Quantity of food (e.g., 200g)
      t.string :unit, null: false                        # Measurement unit (e.g., "grams", "ml", "cups")
      t.decimal :calories, precision: 10, scale: 2       # Calories in the food item
      t.decimal :protein, precision: 10, scale: 2        # Protein content in grams
      t.decimal :carbs, precision: 10, scale: 2          # Carbohydrates in grams
      t.decimal :fats, precision: 10, scale: 2           # Fat content in grams
      
      t.timestamps
    end
  end
end
