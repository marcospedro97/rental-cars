require 'rails_helper'

describe 'Rental Management' do
  context 'show' do
    it 'successfully' do
      # Arrange
      car = create(:car)
      rental = create(:rental, car_category: car.car_model.car_category)
      # Act
      get api_v1_rental_path(rental)
      json = JSON.parse(response.body, symbolize_names: true)
      # Assert
      expect(response.status).to eq(200)
      expect(json[:client_id]).to eq(rental.client.id)
      expect(json[:car_category_id]).to eq(rental.car_category.id)
    end
  end

  context 'create' do
    it 'successfully' do
      # Arrange
      client = create(:client)
      car_category = create(:car_category)
      # Act
      post api_v1_rentals_path, params: { start_date: Date.current,
                                         end_date: 10.days.from_now,
                                         client_id: client.id,
                                         car_category_id: car_category.id }
      json = JSON.parse(response.body, symbolize_names: true)
      # Assert
      expect(response.status).to eq(200)
      expect(json[:client_id]).to eq(client.id)
    end
  end
end
