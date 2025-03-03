class Meal < ApplicationRecord
  belongs_to :user
  has_many :food_items , dependent: :destroy

  def total_macros
    {
      calories: food_items.sum {|item| item.calories * item.servings},
      protein: food_items.sum{|item| item.protein * item.servings},
      carbs: food_items.sum{|item| item.carbs * item.servings},
      fats: food_items.sum{|item| item.fats * item.servings}
    }
  end
end
