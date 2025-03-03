class User < ApplicationRecord
    has_secure_password 
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :weight, presence: true
    validates :height, presence: true

    has_many :workouts, dependent: :destroy
    has_many :workout_plans
    has_many :meals
    has_one :macro_goal, dependent: :destroy
end
