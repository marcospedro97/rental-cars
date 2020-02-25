# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    # Arrange
    manufacturer = create(:manufacturer)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Fabricantes'
    click_on manufacturer.name
    # Assert
    expect(page).to have_content(manufacturer.name)
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    # Arrange
    create(:manufacturer, name: 'Fiat')
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'
    # Assert
    expect(current_path).to eq manufacturers_path
  end
  scenario 'must be authenticated via route' do
    # Act
    visit manufacturers_path
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
