class WorkoutPlanExercise < ApplicationRecord
  belongs_to :workout_plan
  belongs_to :exercise
  
  validates :recommended_sets, numericality: { greater_than: 0 }
  validates :recommended_reps, numericality: { greater_than: 0 }
end 