class Activity < ApplicationRecord
  belongs_to :city

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
