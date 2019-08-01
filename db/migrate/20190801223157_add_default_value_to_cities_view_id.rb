class AddDefaultValueToCitiesViewId < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cities, :view_id, default: 0
  end
end
