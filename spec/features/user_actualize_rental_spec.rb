# frozen_string_literal: true

require 'rails_helper'

feature 'user actualize rental' do
  scenario 'successufully' do
    # Arrange
    car = create(:car)
    rental = create(:rental, car_category: car.car_model.car_category)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit rental_path(rental)
    click_on 'Validar'
    select car.car_identification, from: 'Carro'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Locação efetuada com sucesso')
  end
end
