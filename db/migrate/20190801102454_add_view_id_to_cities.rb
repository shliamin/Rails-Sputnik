class AddViewIdToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :view_id, :integer, default: 0
  end
end
