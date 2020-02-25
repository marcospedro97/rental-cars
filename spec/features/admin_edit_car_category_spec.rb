require 'rails_helper'

feature 'Admin edit car category' do
  scenario 'successfully' do
    # Arrange
    car_category = create(:car_category)
    user = User.create!(email: 'teste@teste.com', password: '123456')
    login_as user, scope: :user

    # Act
    visit root_path
    click_on 'Categorias de Carros'
    click_on car_category.name
    click_on 'Editar'
    fill_in 'Nome', with: 'C'
    fill_in 'Diária Padrão', with: '299'
    fill_in 'Seguro do Carro', with: '2990'
    fill_in 'Seguro para Terceiros', with: '3990'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Categoria C'
    expect(page).to have_content 'Diária Padrão: 299'
    expect(page).to have_content 'Seguro do Carro: 2990'
    expect(page).to have_content 'Seguro para Terceiros: 3990'
  end

  scenario 'must be authenticated via route' do
    # Arrange
    car_category = create(:car_category)
    # Act
    visit edit_car_category_path(car_category)
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
