class MacroGoal < ApplicationRecord
  belongs_to :user
  validates :calories, :protein, :fats, :carbs, presence:true, numericality: { greater_than_or_equal_to: 0}


  def self.calculate_bmr(user)
    # BMR (Basal Metabolic Rate)
    bmr = if user.gender == "male"
            ( 10 * user.weight )  + ( 6.25 * user.height ) - ( 5 * user.age ) + 5
          else 
            ( 10 * user.weight )  + ( 6.25 * user.height ) - ( 5 * user.age ) - 161
          end

    activity_factors = { 
      "sedentary" => 1.2,
      "lightly_active" => 1.375,
      "moderately active" => 1.55,
      "very active" => 1.725,
      "super active" => 1.9
    }

    tdee = bmr * activity_factors[user.activity_level.downcase]

    adjusted_calories = case user.goal.downcase
                        when "weight loss" then tdee - 500
                        when "muscle gain" then tdee + 500
                        else tdee 
                        end 
                        
    protein = (user.weight * 2.2).round
    fat = (adjusted_calories * 0.25 / 9).round
    carb = (( adjusted_calories - (protein * 4) - (fat * 9)) / 4).round

    {
      calories: adjusted_calories,
      protein: protein,
      fats: fat,
      carbs: carb
    }
  end
end
