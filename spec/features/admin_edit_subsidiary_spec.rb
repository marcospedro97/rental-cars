require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    # Arrange
    subsidiary = create(:subsidiary)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Filiais'
    click_on subsidiary.name
    click_on 'Editar'
    fill_in 'Nome', with: 'Vila Matilde'
    fill_in 'CNPJ', with: '56.420.114/0001-47'
    fill_in 'Endereço', with: 'Rua Domingos de Morais, 1002'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Filial Vila Matilde'
    expect(page).to have_content 'CNPJ: 56.420.114/0001-47'
    expect(page).to have_content 'Endereço: Rua Domingos de Morais, 1002'
  end

  scenario 'and must fill in all fields' do
    # Arrange
    create(:subsidiary, name: 'Vila Mariana')
    user = create(:user)
    login_as user, scope: :user

    # Act
    visit root_path
    click_on 'Filiais'
    click_on 'Vila Mariana'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
  end
  scenario 'and must be authenticated via route' do
    # Arrange
    subsidiary = create(:subsidiary)
    # Act
    visit edit_subsidiary_path(subsidiary)
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
