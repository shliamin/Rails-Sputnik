class CreateActivityViews < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_views do |t|
      t.references :visitor, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
