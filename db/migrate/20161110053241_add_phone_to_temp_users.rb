class AddPhoneToTempUsers < ActiveRecord::Migration
  def change
    add_column :temp_users, :phone, :string
  end
end
