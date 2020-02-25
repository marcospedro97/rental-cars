# frozen_string_literal: true

class SubsidiariesController < ApplicationController
  before_action :find_subsidiary, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @subsidiaries = Subsidiary.all
  end

  def show; end

  def new
    @subsidiary = Subsidiary.new
  end

  def edit; end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
      redirect_to @subsidiary
    else
      render :new
    end
  end

  def update
    if @subsidiary.update(subsidiary_params)
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  def destroy
    @subsidiary.destroy
    flash[:notice] = 'Filial apagada com sucesso'
    redirect_to subsidiaries_path
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def find_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end
end
