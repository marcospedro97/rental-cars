# frozen_string_literal: true

require 'rails_helper'

feature 'User login' do
  scenario 'succesfully' do
    # Arrange
    user = create(:user)
    # Act
    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'
    end
    # Assert
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'logout' do
    # Arrange
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Sair'
    # Assert
    expect(page).to have_content('Signed out successfully.')
  end

  scenario 'failed' do
    # Act
    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in 'Email', with: 'alf@gmail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    # Assert
    expect(page).to have_content('Invalid Email or password.')
  end
end
