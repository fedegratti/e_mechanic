class Client < ApplicationRecord
  belongs_to :city
  has_many :cars

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def self.get_by_identification identification
    @client = self.where("identification = ?", "#{identification}")
    @client.first
  end

  def self.get_by_name first_name, last_name
    @client = self.where("first_name ilike ? and last_name ilike ?", "%#{first_name}%", "%#{last_name}%")
    @client.first
  end
end
