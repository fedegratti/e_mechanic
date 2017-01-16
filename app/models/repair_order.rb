class RepairOrder < ApplicationRecord
  belongs_to :car
  belongs_to :mechanic

  def car?
    self.car != nil
  end

  def car_chassis_number
    car.try(:name)
  end

  def car_chassis_number=(name)
    self.car = Car.find_by(chassis_number: name) if name.present?
  end

  def ci_number
    self.car.try(:name)
  end

  def ci_number=(name)
    self.car.client.ci = Car.find_by(ci_number: name) if name.present?
  end

  def car_select
    "car_select"
  end

  def self.get_by_order_number order_number
    @repair_order = self.where("order_number = ?", "#{order_number}")
    @repair_order.first
  end
end
