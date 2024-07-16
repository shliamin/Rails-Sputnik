class ActivityView < ApplicationRecord
  belongs_to :activity
  belongs_to :visitor

  # Validations
  validates :title, :price, :rating, :place, :theme, :duration, presence: true
  validates :user_rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true
end
