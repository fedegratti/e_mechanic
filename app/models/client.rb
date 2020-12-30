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

  def self.get_by_name name
    self.where("first_name ilike ? or last_name ilike ?", "%#{name}%", "%#{name}%").order('updated_at DESC').limit(40)
  end
end
