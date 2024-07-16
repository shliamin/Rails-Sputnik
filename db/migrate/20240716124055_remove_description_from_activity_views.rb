class RemoveDescriptionFromActivityViews < ActiveRecord::Migration[6.1]
  def change
    remove_column :activity_views, :description, :text
  end
end
