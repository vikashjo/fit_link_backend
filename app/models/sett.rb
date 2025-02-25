class Sett < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout

  
  validates :reps, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true
  
end
