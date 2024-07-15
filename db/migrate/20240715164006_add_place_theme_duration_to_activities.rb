class AddPlaceThemeDurationToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :place, :string
    add_column :activities, :theme, :string
    add_column :activities, :duration, :string
  end
end
