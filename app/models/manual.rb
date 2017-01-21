class Manual < ApplicationRecord
  belongs_to :car

  def name
    'Manual'
  end
end
