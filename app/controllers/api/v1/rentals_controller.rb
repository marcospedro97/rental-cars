class Api::V1::RentalsController < Api::V1::ApiController
  def show
    @rental = Rental.find(params[:id])
    render json: @rental
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.code = SecureRandom.hex(6)
    @rental.save
    render json: @rental
  rescue ActiveRecord::RecordInvalid
    render json: '', status: :bad_request
  end

  private

  def rental_params
    params.permit(:start_date, :end_date,
                  :client_id, :car_category_id)
  end
end
