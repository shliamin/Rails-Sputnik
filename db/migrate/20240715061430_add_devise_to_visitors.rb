class AddDeviseToVisitors < ActiveRecord::Migration[6.1]
  def change
    change_table :visitors, bulk: true do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: "" unless column_exists?(:visitors, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:visitors, :encrypted_password)

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:visitors, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:visitors, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:visitors, :remember_created_at)

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps null: false unless column_exists?(:visitors, :created_at)
    end

    add_index :visitors, :email,                unique: true unless index_exists?(:visitors, :email)
    add_index :visitors, :reset_password_token, unique: true unless index_exists?(:visitors, :reset_password_token)
    # add_index :visitors, :confirmation_token,   unique: true
    # add_index :visitors, :unlock_token,         unique: true
  end
end
