class ChangeUsersColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :password, :password_digest
    add_column :users, :avatar, :string
    add_column :users, :bio, :string
  end
end
