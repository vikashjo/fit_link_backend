class Muscle < ApplicationRecord
    belongs_to :muscle_group
    has_many :exercise_muscles
    has_many :exercises, through: :exercise_muscles
end
