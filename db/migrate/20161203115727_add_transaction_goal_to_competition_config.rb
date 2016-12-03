class AddTransactionGoalToCompetitionConfig < ActiveRecord::Migration
  def change
    add_column :competition_configs, :transaction_goal, :decimal, precision: 18, scale: 2, null: false, default: 0
  end
end
