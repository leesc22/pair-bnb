class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :role, :integer, default: 0
    User.update_all(role: 0)
  end

  def down
  	remove_column :users, :role
  end
end
