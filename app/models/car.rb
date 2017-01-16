class Car < ApplicationRecord
  belongs_to :client
  has_one :manual
  has_many :technical_reports
  has_many :repair_orders

  alias_attribute :name,:model

  def self.get_by_chassis_number chassis_number
    @car = self.where("chassis_number = ?", "#{chassis_number}")
    @car.first
  end

  def name
    "#{self.brand} #{self.model} (Chasis: #{self.chassis_number.upcase})" #, Cliente: #{self.client.name})
  end
end
