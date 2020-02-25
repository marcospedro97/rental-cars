require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    # Arrange
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Fiat')
  end

  scenario 'and must fill in all fields' do
    # Arrange
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit new_manufacturer_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Você deve preencher todos os campos')
  end

  scenario 'and name must be unique' do
    # Arrange
    create(:manufacturer)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit new_manufacturer_path
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Nome já está em uso')
  end
  scenario 'must be authenticated via route' do
    # Act
    visit new_manufacturer_path
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
