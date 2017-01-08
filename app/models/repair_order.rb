class RepairOrder < ApplicationRecord
  belongs_to :car

  def car?
    self.car != nil
  end
end
