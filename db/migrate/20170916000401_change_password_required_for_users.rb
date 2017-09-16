class ChangePasswordRequiredForUsers < ActiveRecord::Migration[5.1]
  def up
  	change_column_null :users, :encrypted_password, true
  end

  def down
  	change_column_null :users, :encrypted_password, false
  end
end
