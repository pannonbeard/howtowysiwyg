class AddScenariosIdToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :scenario_id, :string
    add_index :directions, :scenario_id
  end
end
