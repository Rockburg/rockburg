class RemoveDevise < ActiveRecord::Migration[6.0]
  def change
    remove_column :managers, :encrypted_password
    remove_column :managers, :reset_password_token
    remove_column :managers, :reset_password_sent_at
    remove_column :managers, :remember_created_at
    remove_column :managers, :sign_in_count
    remove_column :managers, :current_sign_in_at
    remove_column :managers, :last_sign_in_at
    remove_column :managers, :current_sign_in_ip
    remove_column :managers, :last_sign_in_ip
  end
end
