class Mechanic < ApplicationRecord
  belongs_to :city
  has_many :repair_orders

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def self.get_by_name name
    @mechanic = self.where("first_name like ? or last_name like ?", "%#{name}%", "%#{name}%")
    @mechanic.first
  end
end
