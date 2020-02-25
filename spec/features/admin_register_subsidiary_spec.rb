# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    # Arrange
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'
    fill_in 'Nome', with: 'Vila Mariana'
    fill_in 'CNPJ', with: '56.420.114/0001-45'
    fill_in 'Endereço', with: 'Rua Domingos de Morais, 1000'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Filial Vila Mariana'
    expect(page).to have_content 'CNPJ: 56.420.114/0001-45'
    expect(page).to have_content 'Endereço: Rua Domingos de Morais, 1000'
  end

  scenario 'and must fill in all fields' do
    # Arrange
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
  end
  scenario 'and must be authenticated via route' do
    # Act
    visit new_subsidiary_path
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
