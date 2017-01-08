class CreateManuals < ActiveRecord::Migration[5.0]
  def change
    create_table :manuals do |t|
      t.references :car, foreign_key: true
      t.string :operation_number

      t.timestamps
    end
  end
end
