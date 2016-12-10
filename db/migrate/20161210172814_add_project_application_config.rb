class AddProjectApplicationConfig < ActiveRecord::Migration
  def change
    add_column :competition_configs, :open_application, :boolean, default: false
    add_column :competition_configs, :application_email, :string, default: ""
  end
end
