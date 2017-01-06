class CreateTechnicalReports < ActiveRecord::Migration[5.0]
  def change
    create_table :technical_reports do |t|
      t.belongs_to :car, index: true
      t.string :picture

      t.timestamps
    end
  end
end
