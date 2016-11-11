class CreateProductFeatures < ActiveRecord::Migration
  def change
    create_table :product_features, id: false do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    execute "ALTER TABLE product_features ADD PRIMARY KEY (name);"
  end
end
