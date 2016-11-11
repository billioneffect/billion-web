class CreateCompetitionFeatures < ActiveRecord::Migration
  def change
    create_table :competition_features do |t|
      t.integer :competition_id, index: true
      t.string :product_feature_id, index: true
    end
    add_foreign_key :competition_features, :competitions
    add_foreign_key :competition_features, :product_features, primary_key: :name
  end
end
