class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :city_id
      t.string :title
      t.string :description
      t.string :photo
      t.integer :price
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
