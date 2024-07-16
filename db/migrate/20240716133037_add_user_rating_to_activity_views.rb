class AddUserRatingToActivityViews < ActiveRecord::Migration[6.1]
  def change
    add_column :activity_views, :user_rating, :decimal
  end
end
