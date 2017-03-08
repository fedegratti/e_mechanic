class AddMobilePhoneToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :mobile_phone, :integer, :limit => 8
  end
end
