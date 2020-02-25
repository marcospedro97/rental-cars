# frozen_string_literal: true

require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'successfully' do
    # Arrange
    create(:car_category, name: 'D')
    create(:car_category, name: 'C')
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Categorias de Carros'
    # Assert
    expect(current_path).to eq car_categories_path
    expect(page).to have_content 'C'
    expect(page).to have_content 'D'
  end

  scenario 'and view details' do
    # Arrange
    create(:car_category, name: 'D')
    car_category = create(:car_category, name: 'C')
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Categorias de Carros'
    click_on car_category.name
    # Assert
    expect(page).to have_content car_category.name
    expect(page).to have_content car_category.daily_rate
    expect(page).to have_content car_category.third_party_insurance
    expect(page).to have_content car_category.car_insurance
  end
  scenario 'must be authenticated via route' do
    # Act
    visit car_categories_path
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
