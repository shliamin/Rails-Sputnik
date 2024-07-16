class ActivityView < ApplicationRecord
  belongs_to :activity
  belongs_to :visitor

  # Validations 
  validates :title, :price, :rating, :place, :theme, :duration, presence: true
end
