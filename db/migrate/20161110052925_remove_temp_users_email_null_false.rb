class RemoveTempUsersEmailNullFalse < ActiveRecord::Migration
  def change
    change_column :temp_users, :email, :string, :null => true
  end
end
