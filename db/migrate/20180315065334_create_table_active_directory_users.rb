class CreateTableActiveDirectoryUsers < ActiveRecord::Migration
  def change
    create_table :active_directory_users do |t|
      t.string :user_id
      t.string :sam_account_name
      t.string :display_name
      t.string :mail
      t.string :department
    end

    add_index :active_directory_users, :user_id, unique: true

  end
end
