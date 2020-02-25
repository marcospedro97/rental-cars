require 'rails_helper'

feature 'Admin register car' do
  scenario 'succesfully' do
    # Arrange
    subsidiary = create(:subsidiary)
    car_model = create(:car_model)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Carros para Locação'
    click_on 'Registrar Carro'
    fill_in 'Placa', with: 'KHG-9898'
    fill_in 'Cor', with: 'Azul'
    fill_in 'Kilometragem', with: '31'
    select car_model.name, from: 'Modelo'
    select subsidiary.name, from: 'Filial'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Carro cadastrado com sucesso')
  end
end
