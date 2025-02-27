class FoodItem < ApplicationRecord
  belongs_to :meal

  def total_protein
    total = self.servings * self.protein
    "#{total.to_i} gm"
  end

  def total_calories
    total = self.servings * self.calories
    "#{total.to_i} "
  end

  def total_fats
    total = self.servings * self.fats
    "#{total.to_i} gm"
  end

  def total_carbs
    total = self.servings * self.carbs
    "#{total.to_i} gm"
  end


end
