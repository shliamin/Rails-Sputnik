class CreateVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :visitors do |t|
      t.string :email
      t.string :encrypted_password

      t.timestamps
    end
  end
end
