class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.belongs_to :city, index: true
      t.string :first_name
      t.string :last_name
      t.string :address
      t.integer :telephone
      t.integer :ci
      t.integer :ruc

      t.timestamps
    end
  end
end
