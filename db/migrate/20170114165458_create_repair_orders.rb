class CreateRepairOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :repair_orders do |t|
      t.references :car, foreign_key: true
      t.references :mechanic, foreign_key: true
      t.integer :order_number
      t.string :description
      t.string :note
      t.boolean :ayax
      t.integer :claim_number
      t.string :operation_number
      t.string :order_type
      t.integer :kilometers, :limit => 8
      t.date :repair_date
      t.date :compliance_date
      t.string :ayax_service_type
      t.string :ayax_repair_type

      t.timestamps
    end
  end
end
