class AddAttachmentProfileImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :profile_image
      t.string :first_name
      t.string :last_name
    end
  end

  def self.down
    remove_attachment :users, :profile_image
    change_table :users do
      remove_column :first_name
      remove_column :last_name
    end
  end
end
