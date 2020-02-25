# frozen_string_literal: true

require 'rails_helper'

feature 'Admin view car models' do
  scenario 'succesfully' do
    # Arrange
    manufacturer = create(:manufacturer, name: 'Volkswagen')
    car = create(:car_model)
    other_car = create(:car_model, name: 'Fox', manufacturer: manufacturer)
    user = User.create!(email: 'teste@teste.com', password: '123456')
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Modelos de Carros'
    # Assert
    expect(current_path).to eq car_models_path
    expect(page).to have_content(car.name)
    expect(page).to have_content(car.year)
    expect(page).to have_content(car.motorization)
    expect(page).to have_content 'Fox'
    expect(page).to have_content(other_car.year)
    expect(page).to have_content 'Flex', count: 2
    expect(page).to have_content(other_car.motorization)
  end

  scenario 'and car models dont exist' do
    # Arrange
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Modelos de Carros'

    # Assert
    expect(current_path).to eq car_models_path
    expect(page).to have_content 'Nenhum Modelo de carro registrado ainda'
  end

  scenario 'must be authenticated via route' do
    # Act
    visit car_models_path
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
