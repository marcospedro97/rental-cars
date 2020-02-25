class CarRental < ApplicationRecord
  belongs_to :car
  belongs_to :rental
  validates :daily_rate, presence: true
  validates :thirdy_party_insurance, presence: true
  validates :car_insurance, presence: true
end
