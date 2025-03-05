class FoodEntry < ApplicationRecord
  belongs_to :food_item
  belongs_to :meal


  def total_calories
    total = servings * food_item.calories
    "#{total.to_i} gm"
  end

  def total_protein
    total = servings * food_item.protein
    "#{total.to_i} gm"
  end

  def total_carbs
    total = servings * food_item.carbs
    "#{total.to_i} gm"
  end

  def total_fats
    total = servings * food_item.fats
    "#{total.to_i} gm"
  end
end
