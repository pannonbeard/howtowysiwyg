class AddDirectionToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :direction_id, :string
    add_index :entries, :direction_id
  end
end
