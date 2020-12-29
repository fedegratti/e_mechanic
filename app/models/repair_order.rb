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
    repair_order = self.where("order_number = ?", "#{order_number}")
    repair_order.first
  end

  def self.get_many_by_order_number order_number
    repair_orders = self.where("CAST(order_number AS TEXT) ilike ?", "%#{order_number}%").order('order_number DESC')
    repair_orders = [] unless !repair_orders.nil?
    repair_orders
  end

  def self.get_by_chassis_number chassis_number
    car = Car.get_by_chassis_number chassis_number

    repair_orders = car.repair_orders unless car.nil?
    repair_orders = [] unless !repair_orders.nil?
    repair_orders
  end

  def self.get_by_identification identification
    client = Client.get_by_identification identification
    repair_orders = nil
    unless client.nil? then
      # if client.cars.empty? then
      #   repair_orders = []
      # else
        client.cars.each do |car|
          if repair_orders.nil? then
            repair_orders = car.repair_orders
          else
            repair_orders += car.repair_orders
          end
        end
      # end
    end

    repair_orders = repair_orders.nil? ? [] : repair_orders
    repair_orders
  end

end
