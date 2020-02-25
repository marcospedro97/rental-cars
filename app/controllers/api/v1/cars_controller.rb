class Api::V1::CarsController < Api::V1::ApiController
  
  def index
    @cars = Car.all
    render json: @cars
  end

  def show
    @car = Car.find(params[:id])
    render json: @car
  end

  def create
    @car = Car.create!(car_params)
    render  json: @car
  rescue ActiveRecord::RecordInvalid
    render json: '', status: :bad_request
  end

  def status
    @car = Car.find(params[:id])
    if params[:status] == 'unavailable'
      @car.unavailable!
    else
      @car.available!
    end
    render json: @car
  end
  private

  def car_params
    params.permit(:license_plate, :color, :car_model_id,
                  :mileage, :subsidiary_id)
  end
end