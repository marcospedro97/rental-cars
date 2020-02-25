require 'rails_helper'

describe 'Car Management' do
  context 'show' do
    it 'renders a json successfully' do
        # Arrange
        car = create(:car)
        # Act
        get api_v1_car_path(car)
        json = JSON.parse(response.body, symbolize_names: true)
        # Assert
        expect(response).to have_http_status(200)
        expect(json[:license_plate]).to eq(car.license_plate)
        expect(json[:color]).to eq(car.color)
    end
  end

  context 'index' do
    it 'renders a json successfully' do
        # Arrange
        car = create(:car)
        other_car = create(:car, car_model: car.car_model, license_plate: 'asd-1234')
        # Act
        get api_v1_cars_path
        json = JSON.parse(response.body, symbolize_names: true)
        # Assert
        expect(response).to have_http_status(200)
        expect(json.length).to eq(2)
    end
  end

  context 'create' do
    it 'receive expected json response' do
        # Arrange
        subsidiary = create(:subsidiary)
        car_model = create(:car_model)
        # Act
        post api_v1_cars_path, params: { license_plate:'asd-1234',
                                        color: 'Azul', car_model_id: car_model.id,
                                        mileage: 150, subsidiary_id: subsidiary.id }
        json = JSON.parse(response.body, symbolize_names: true)
        # Assert
        expect(json[:license_plate]).to eq('asd-1234')
        expect(json[:color]).to eq('Azul')
    end

    it 'failed' do
      post api_v1_cars_path, params: {}

      expect(response.status).to eq(400)
    end
  end

  context 'change status' do
    it 'change status to unavailable successfully' do
      # Arrange
      car = create(:car)
      # Act
      patch status_api_v1_car_path(car), params: { status: 'unavailable'}
      json = JSON.parse(response.body, symbolize_names: true)
      # Assert
      expect(response.status).to eq(200)
      expect(json[:status]).to include(car.status)
    end

    it 'change status to available successfully' do
      # Arrange
      car = create(:car)
      # Act
      patch status_api_v1_car_path(car), params: { status: 'available'}
      json = JSON.parse(response.body, symbolize_names: true)
      # Assert
      expect(response.status).to eq(200)
      expect(json[:status]).to include(car.status)
    end
  end
end
