class Client < ApplicationRecord
  belongs_to :city
  has_many :cars
end
