class CreateMechanics < ActiveRecord::Migration[5.0]
  def change
    create_table :mechanics do |t|
      t.references :city, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.integer :telephone
      t.string :address
      t.string :email
      t.string :identification

      t.timestamps
    end
  end
end
