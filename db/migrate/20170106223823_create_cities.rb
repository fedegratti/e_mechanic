class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.belongs_to :state, index: true
      t.string :name
      t.string :zip_code

      t.timestamps
    end
  end
end
