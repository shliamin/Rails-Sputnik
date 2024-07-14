class City < ApplicationRecord
  has_many :activities, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :photo, presence: true
  validates :description, presence: true
end
