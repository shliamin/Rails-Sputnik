class Activity < ApplicationRecord
  belongs_to :city
  has_many :activity_views
  has_many :viewing_visitors, through: :activity_views, source: :visitor

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
