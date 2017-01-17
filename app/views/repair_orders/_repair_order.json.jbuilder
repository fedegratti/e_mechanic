json.extract! repair_order, :id, :car_id, :order_number, :description, :ayax, :claim_number, :operation_number, :created_at, :updated_at
json.url repair_order_url(repair_order, format: :json)
