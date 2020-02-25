class Car < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :car_model
  enum status: { available: 0, unavailable: 10 }
  
  def car_identification
    "#{license_plate} #{color} #{car_model.name}"
  end
end
