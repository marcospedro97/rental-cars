# frozen_string_literal: true

class CarsController < ApplicationController
  before_action :find_car, only: [:show]
  def index
    @cars = Car.all
  end

  def show; end

  def new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash[:notice] = 'Carro cadastrado com sucesso'
      redirect_to @car
    else
      @car_models = CarModel.all
      @subsidiaries = Subsidiary.all
      render :new
    end
  end

  private

  def find_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:license_plate, :color, :model, :mileage,
                                :subsidiary_id, :car_model_id)
  end
end
