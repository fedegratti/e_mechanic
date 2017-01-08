class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.references :client, foreign_key: true
      t.string :brand
      t.string :model
      t.string :chassis_number
      t.string :engine_number
      t.string :plate
      t.integer :kilometers
      t.date :sell_date

      t.timestamps
    end
  end
end
