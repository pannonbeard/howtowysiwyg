class AddInformationToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :information, :text
  end
end
