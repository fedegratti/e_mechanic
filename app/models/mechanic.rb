class Mechanic < ApplicationRecord
  belongs_to :city
  has_many :repair_orders

  def self.get_by_name name
    @mechanic = self.where("first_name like ? or last_name like ?", "%#{name}%", "%#{name}%")
    @mechanic.first
  end
end
