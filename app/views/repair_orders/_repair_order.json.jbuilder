json.extract! repair_order, :id, :order_number, :description, :ajax, :created_at, :updated_at
json.url repair_order_url(repair_order, format: :json)