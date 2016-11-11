class CreateCompetitionConfig < ActiveRecord::Migration
  def change
    create_table :competition_configs do |t|
      t.references :competition, index: true
      t.integer :sms_votes_allowed, default: 1, null: false
    end
    add_foreign_key :competition_configs, :competitions
  end
end
