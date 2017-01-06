class Car < ApplicationRecord
  belongs_to :client
  has_one :manual
  has_many :technical_reports
  has_many :repair_orders
end
