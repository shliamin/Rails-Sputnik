class AddViewIdToCities < ActiveRecord::Migration[6.1]
  def change
    add_column :cities, :view_id, :integer
  end
end
