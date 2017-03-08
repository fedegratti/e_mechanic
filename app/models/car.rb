class Car < ApplicationRecord
  belongs_to :client
  has_one :manual
  has_many :technical_reports
  has_many :repair_orders

  alias_attribute :name,:model

  def client?
    self.client != nil
  end

  def self.get_by_chassis_number chassis_number
    @car = self.where("chassis_number = ?", "#{chassis_number}")
    @car.first
  end

  def self.get_by_identification identification
    self.where("chassis_number ilike ? or engine_number ilike ?", "%#{identification}%", "%#{identification}%")
  end

  def name
    "#{self.brand} #{self.model} (Chasis: #{self.chassis_number.upcase})" #, Cliente: #{self.client.name})
  end
end
