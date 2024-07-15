class Activity < ApplicationRecord
  belongs_to :city

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  # Удалите этот блок
  # settings index: { number_of_shards: 1 } do
  #   mappings dynamic: false do
  #     indexes :title, type: :text, analyzer: :english
  #     indexes :description, type: :text, analyzer: :english
  #     indexes :photo, type: :keyword
  #     indexes :price, type: :double
  #     indexes :rating, type: :double
  #     indexes :created_at, type: :date
  #     indexes :updated_at, type: :date
  #     indexes :city_id, type: :integer
  #   end
  # end

  # Удалите этот метод
  # def self.search(query)
  #   __elasticsearch__.search(
  #     {
  #       query: {
  #         multi_match: {
  #           query: query,
  #           fields: ['title^10', 'description']
  #         }
  #       }
  #     }
  #   )
  # end

  # Удалите этот блок
  # begin
  #   Activity.__elasticsearch__.client.indices.delete index: Activity.index_name
  # rescue Elasticsearch::Transport::Transport::Errors::NotFound
  #   # Ignore if the index does not exist
  # end

  # Activity.__elasticsearch__.client.indices.create(
  #   index: Activity.index_name,
  #   body: { settings: Activity.settings.to_hash, mappings: Activity.mappings.to_hash }
  # )

  # Activity.import
end
