# frozen_string_literal: true

class CarCategoriesController < ApplicationController
  before_action :find_car_category, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @car_categories = CarCategory.all
  end

  def show; end

  def new
    @car_category = CarCategory.new
  end

  def edit; end

  def create
    @car_category = CarCategory.new(car_category_params)
    if @car_category.save
      redirect_to @car_category
    else
      render :new
    end
  end

  def update
    @car_category.update(car_category_params)
    redirect_to @car_category
  end

  def destroy
    @car_category.destroy
    flash[:notice] = 'Categoria apagada com sucesso'
    redirect_to car_categories_path
  end

  private

  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance,
                                         :third_party_insurance)
  end

  def find_car_category
    @car_category = CarCategory.find(params[:id])
  end
end
