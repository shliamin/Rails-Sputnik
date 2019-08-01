class AddViewIdToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :view_id, :integer
  end
end
