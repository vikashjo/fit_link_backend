class FoodItem < ApplicationRecord
  has_many :food_entries
  has_many :meals, through: :food_entries

end
