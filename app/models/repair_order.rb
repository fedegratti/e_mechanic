class RepairOrder < ApplicationRecord
  belongs_to :car

  def car?
    self.car != nil
  end

  def car_chassis_number
    car.try(:name)
  end

  def car_chassis_number=(name)
    self.car = Car.find_by(chassis_number: name) if name.present?
  end
end
