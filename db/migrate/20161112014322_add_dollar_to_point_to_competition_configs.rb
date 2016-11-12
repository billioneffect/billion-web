class AddDollarToPointToCompetitionConfigs < ActiveRecord::Migration
  def change
    add_column :competition_configs, :dollar_to_point, :integer, default: 1, null: false
  end
end
