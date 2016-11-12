class RemoveDollarToPointFromCompetitions < ActiveRecord::Migration
  def change
    remove_column :competitions, :dollar_to_point, :integer
  end
end
