class AddActiveToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :active, :boolean, default: false
  end
end
