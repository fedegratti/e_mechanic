class CreateRepairOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :repair_orders do |t|
      t.belongs_to :car, index: true
      t.integer :order_number
      t.integer :claim_number #campaign only
      t.string :operation_number #campaign only
      t.string :description
      t.string :type
      t.boolean :ajax

      t.timestamps
    end
  end
end
