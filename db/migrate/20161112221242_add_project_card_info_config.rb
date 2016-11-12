class AddProjectCardInfoConfig < ActiveRecord::Migration
  def change
    add_column :competition_configs, :project_card_info, :string, null: false, default: 'none'
  end
end
