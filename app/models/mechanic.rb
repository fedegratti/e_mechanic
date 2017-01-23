class Mechanic < ApplicationRecord
  belongs_to :city
  has_many :repair_orders

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def self.get_by_name name
    @mechanic = self.where("first_name ilike ? or last_name ilike ?", "%#{name}%", "%#{name}%")
    @mechanic.first
  end
end
