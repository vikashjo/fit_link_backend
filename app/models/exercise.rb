class Exercise < ApplicationRecord
    has_many :setts, dependent: :destroy
    has_many :workouts, through: :setts
    belongs_to :muscle_group
    belongs_to :primary_muscle, class_name: 'Muscle', optional: true
    has_many :exercise_muscles, dependent: :destroy
    has_many :secondary_muscles, through: :exercise_muscles, source: :muscle
end
