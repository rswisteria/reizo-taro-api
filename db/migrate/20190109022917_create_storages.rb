class CreateStorages < ActiveRecord::Migration[5.2]
  def change
    create_table :storages do |t|
      t.string :food
      t.integer :count

      t.timestamps
    end
  end
end
