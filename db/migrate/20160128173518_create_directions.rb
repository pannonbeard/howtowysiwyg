class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
