class CreateRepairOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :repair_orders do |t|
      t.references :car, foreign_key: true
      t.integer :order_number
      t.string :description
      t.boolean :ajax
      t.integer :claim_number
      t.string :operation_number
      t.string :type

      t.timestamps
    end
  end
end
