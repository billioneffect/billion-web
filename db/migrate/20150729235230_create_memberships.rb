class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :project, null: false, index: true
      t.references :user, null: false, index: true
    end
  end
end
