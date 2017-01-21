class ChangeTypeToClientType < ActiveRecord::Migration[5.0]
  def change
    rename_column :clients, :type, :client_type
  end
end
