class CarCategory < ApplicationRecord
  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :daily_rate, presence: { message: 'Diária Padrão não pode ficar em branco' }
  validates :car_insurance, presence: { message: 'Seguro do Carro não pode ficar em branco' }
  validates :third_party_insurance, presence: { message: 'Seguro para Terceiros não pode ficar em branco' }
  validates :daily_rate, numericality: { message: 'Diária Padrão deve ser um valor numérico' }
  validates :car_insurance, numericality: { message: 'Seguro do Carro deve ser um valor numérico' }
  validates :third_party_insurance, numericality: { message: 'Seguro para Terceiros deve ser um valor numérico' }
end
