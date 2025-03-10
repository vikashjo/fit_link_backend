class Meal < ApplicationRecord
  belongs_to :user
  has_many :food_entries, dependent: :destroy
  has_many :food_items , through: :food_entries
  belongs_to :meal_type
  accepts_nested_attributes_for :food_entries

  def total_macros
    {
      calories: food_entries.sum {|entry| entry.food_item.calories * entry.servings },
      protein: food_entries.sum{|entry| entry.food_item.protein * entry.servings },
      carbs: food_entries.sum{|entry| entry.food_item.carbs * entry.servings },
      fats: food_entries.sum{|entry| entry.food_item.fats * entry.servings }
    }
  end
end
