class City < ApplicationRecord
  belongs_to :state
  has_many :clients

  def self.get_by_name name
    @city = self.where("name like ?", "%#{name}%")
    @city.first
  end
end
