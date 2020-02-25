# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    # Arrange
    Manufacturer.create!(name: 'Fiat')
    user = create(:user)
    login_as user, scope: :user

    # Act
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Honda')
    expect(page).to have_content('Fabricante atualizada com sucesso')
  end

  scenario 'and must fill in all fields' do
    # Arrange
    Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'teste@teste.com', password: '123456')
    login_as user, scope: :user

    # Act
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'and must be unique' do
    # Arrange
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')
    user = User.create!(email: 'teste@teste.com', password: '123456')
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'must be authenticated via route' do
    # Arrange
    manufacturer = create(:manufacturer)
    # Act
    visit edit_manufacturer_path(manufacturer)
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
