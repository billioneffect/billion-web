class AddSmsCodeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :sms_code, :string
  end
end
