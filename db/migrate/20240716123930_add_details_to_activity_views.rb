class AddDetailsToActivityViews < ActiveRecord::Migration[6.1]
  def change
    add_column :activity_views, :title, :string
    add_column :activity_views, :description, :text
    add_column :activity_views, :price, :decimal
    add_column :activity_views, :rating, :decimal
    add_column :activity_views, :place, :string
    add_column :activity_views, :theme, :string
    add_column :activity_views, :duration, :string
  end
end
