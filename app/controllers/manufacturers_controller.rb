# frozen_string_literal: true

class ManufacturersController < ApplicationController
  before_action :find_manufacturer, only: %i[show edit update]
  before_action :authenticate_user!

  def index
    @manufacturers = Manufacturer.all
  end

  def show; end

  def new
    @manufacturer = Manufacturer.new
  end

  def edit; end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)

    if @manufacturer.save
      redirect_to @manufacturer
    else
      flash.now[:alert] = 'Você deve preencher todos os campos'
      render :new
    end
  end

  def update
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = 'Fabricante atualizada com sucesso'
      redirect_to @manufacturer
    else
      render :edit
    end
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end

  def find_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end
end
