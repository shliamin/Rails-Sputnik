class AddRatingToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :rating, :decimal
  end
end
