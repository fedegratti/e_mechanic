class Client < ApplicationRecord
  belongs_to :city
  has_many :cars

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
