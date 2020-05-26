class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  validates :code, presence: true
  validates :client, presence: { message: 'Cliente não pode ficar em branco' }
  validates :car_category, presence: { message: 'Categoria de carro não pode ficar em branco' }
  validates :start_date, presence: { message: 'Data da Locação não pode ficar em branco' }
  validates :end_date, presence: { message: 'Data Final da Locação não pode ficar em branco' }
  enum status: { scheduled: 0, in_progress: 1 }
  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_before_start_date
  validate :must_have_available_cars

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? and start_date.strftime('%d/%m/%y') <  Date.current.strftime('%d/%m/%y')
      return errors.add(:start_date, 'Data inicial não pode ser antes de hoje') 
    end
  end

  def end_date_cannot_be_before_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      return errors.add(:end_date, 'Data final não pode ser antes da data inicial')
    end
  end

  def must_have_available_cars
    if cars_available? && start_date.present? && end_date.present?
      return errors.add(:base, 'Não existem carros disponíveis desta categoria')
    end
  end

  def scheduled_rentals
    Rental.where(car_category: car_category)
          .where(start_date: start_date..end_date)
          .or(Rental.where(car_category: car_category)
                    .where(end_date: start_date..end_date)
    )
  end

  def available_cars
    Car.where(status: :available)
       .joins(:car_model)
       .where(car_models: { car_category: car_category })
  end

  def cars_available?
    scheduled_rentals.count >= available_cars.count
  end
end
