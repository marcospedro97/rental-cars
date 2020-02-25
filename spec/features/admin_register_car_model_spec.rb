require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    # Arrange
    create(:car_category)
    create(:car_category, name: 'B')
    create(:manufacturer, name: 'Volkswagen')
    create(:manufacturer)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Registrar modelo de Carro'
    fill_in 'Nome', with: 'Uno'
    fill_in 'Ano', with: '2015'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Tipo de Combustível', with: 'Flex'
    select 'Volkswagen', from: 'Fabricante'
    select 'A', from: 'Categoria'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Modelo de carro criado com sucesso')
    expect(page).to have_content('Uno')
    expect(page).to have_content('2015')
    expect(page).to have_content('1.0')
    expect(page).to have_css('p', text: 'A')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('Flex')
  end

  scenario 'and must fill in all fields' do
    # Arrange
    create(:car_category)
    create(:manufacturer)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Registrar modelo de Carro'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Nome não deve ficar em branco')
    expect(page).to have_content('Tipo de Combustível não deve ficar em branco')
    expect(page).to have_content('Motorização não deve ficar em branco')
    expect(page).to have_content('Ano não deve ficar em branco')
  end
  scenario 'must be authenticated via route' do
    # Act
    visit new_car_model_path
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
