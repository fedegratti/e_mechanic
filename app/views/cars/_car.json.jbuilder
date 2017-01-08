json.extract! car, :id, :client_id, :brand, :model, :chassis_number, :engine_number, :plate, :kilometers, :sell_date, :created_at, :updated_at
json.url car_url(car, format: :json)