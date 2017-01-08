json.extract! client, :id, :city_id, :first_name, :last_name, :telephone, :address, :email, :ci, :ruc, :created_at, :updated_at
json.url client_url(client, format: :json)