class UsersResetPasswordFieldsDelete < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :reset_password_token
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at

  end
end
