# t.bigint "exercise_id", null: false
# t.bigint "workout_id", null: false
# t.integer "reps"
# t.integer "weight"

class Sett < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout

  
  validates :reps, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
end
