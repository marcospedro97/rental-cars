require 'rails_helper'

feature 'admin delete subsidiary' do
  scenario 'succesfully' do
    # Arrange
    subsidiary = create(:subsidiary)
    # Act
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
    click_on subsidiary.name
    click_on 'Apagar'
    # Assert
    expect(page).to have_no_content(subsidiary.name)
    expect(page).to have_content('Filial apagada com sucesso')
  end
end
