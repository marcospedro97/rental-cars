# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_rental, only: %i[show actualize_post]
  def index
    @rentals = Rental.all
  end

  def show; end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.code = SecureRandom.hex(6)
    if @rental.save
      flash[:notice] = 'Locação agendada com sucesso'
      redirect_to @rental
    else
      @clients = Client.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  def search
    @rentals = Rental.where('UPPER(code) LIKE ?', "%#{params[:q]}%")
  end

  def actualize
    @car_rental = CarRental.new
    @cars = Car.all
  end

  def actualize_post
    @car = Car.find(params[:id])
    @car_category = @car.car_model.car_category
    @car_rental = CarRental.create(car: @car, rental: @rental,
                                   daily_rate: @car_category.daily_rate,
                                   car_insurance: @car_category.car_insurance,
                                   thirdy_party_insurance: @car_category.third_party_insurance)
    @rental.update(status: :in_progress)
    if @car_rental.save
      flash[:notice] = 'Locação efetuada com sucesso'
      redirect_to @rental
    else
      @car_rental = CarRental.new
      @cars = Car.all
      render :actualize
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date,
                                   :client_id, :car_category_id)
  end

  def find_rental
    @rental = Rental.find(params[:id])
  end
end
