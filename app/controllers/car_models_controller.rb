# frozen_string_literal: true

class CarModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_car_model, only: [:show]

  def index
    @car_models = CarModel.all
  end

  def show; end

  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def create
    @car_model = CarModel.new(client_params)
    if @car_model.save
      flash[:notice] = 'Modelo de carro criado com sucesso'
      redirect_to @car_model
    else
      @manufacturers = Manufacturer.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  private

  def client_params
    params.require(:car_model).permit(:name, :year, :fuel_type, :motorization,
                                      :manufacturer_id, :car_category_id)
  end

  def find_car_model
    @car_model = CarModel.find(params[:id])
  end
end
