class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author, default: '', null: false
      t.text :content, default: '', null: false
      t.references :project, null: false, index: true

      t.timestamps null: false
    end
  end
end
