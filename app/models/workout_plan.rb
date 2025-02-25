class WorkoutPlan < ApplicationRecord
  belongs_to :user
  has_many :workout_plan_exercises, dependent: :destroy
  has_many :exercises, through: :workout_plan_exercises
  
  validates :name, presence: true
  validates :description, presence: true
  
  scope :templates, -> { where(is_template: true) }
  scope :user_workouts, -> { where(is_template: false) }

  accepts_nested_attributes_for :workout_plan_exercises
end 