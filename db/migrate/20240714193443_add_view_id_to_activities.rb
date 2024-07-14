class AddViewIdToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :view_id, :integer
  end
end
