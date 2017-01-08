class Car < ApplicationRecord
  belongs_to :client
  has_one :manual
  has_many :technical_reports
  has_many :repair_orders

  alias_attribute :name,:model

  def name
    "#{self.brand} #{self.model} (Cliente: #{self.client.name})"
  end
end
