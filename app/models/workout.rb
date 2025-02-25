class Workout < ApplicationRecord
  belongs_to :user
  has_many :setts, dependent: :destroy
  has_many :exercises, through: :setts

  validates :date, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validate :date_cannot_be_in_future

  private

  def date_cannot_be_in_future
    if date.present? && date > Date.current
      errors.add(:date, "can't be in the future")
    end
  end
end
