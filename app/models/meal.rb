class Meal < ApplicationRecord
  belongs_to :user
  has_many :food_items , dependent: :destroy
end
