json.extract! city, :id, :state_id, :name, :zip_code, :created_at, :updated_at
json.url city_url(city, format: :json)