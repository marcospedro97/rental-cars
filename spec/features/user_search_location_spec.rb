# frozen_string_literal: true

require 'rails_helper'

feature 'user search location' do
  scenario 'successfully' do
    # Arrange
    car = create(:car)
    other_car = create(:car, car_model: car.car_model)
    rental = create(:rental, code: 'XFB0002', car_category: car.car_model.car_category)
    other_rental = create(:rental, code: 'XFB0001', car_category: car.car_model.car_category )
    user = create(:user)
    login_as(user, scope: :user)
    # Act
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisa', with: 'XFB0002'
    click_on 'Buscar'
    # Assert
    expect(page).to have_content(rental.client.name)
    expect(page).to have_content(rental.code)
    expect(page).not_to have_content(other_rental.code)
  end
  scenario 'Not Found' do
    # Arrange
    user = create(:user)
    login_as(user, scope: :user)
    # Act
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisa', with: 'XFB0009'
    click_on 'Buscar'
    # Assert
    expect(page).to have_content('Nenhuma Locação encontrada com os parâmetros')
  end
  scenario 'Empty search field' do
    # Arrange
    car = create(:car)
    other_car = create(:car, car_model: car.car_model)
    create(:rental, code: 'XFB0002', car_category: car.car_model.car_category)
    create(:rental, code: 'XFB0001', car_category: car.car_model.car_category )
    user = create(:user)
    login_as(user, scope: :user)
    # Act
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisa', with: 'XFB'
    click_on 'Buscar'
    # Assert
    expect(page).to have_content('Foram encontradas 2 Locações')
    expect(page).to have_content('XFB', count: 2)
  end
end
