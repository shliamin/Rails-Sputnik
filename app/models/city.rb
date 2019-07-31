class City < ApplicationRecord
  has_many :activities, dependent: :destroy
end
