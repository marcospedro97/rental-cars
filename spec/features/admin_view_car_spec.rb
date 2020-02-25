require 'rails_helper'

feature 'admin view cars' do
  scenario 'succesfully' do
    # Arrange
    car = create(:car)
    # Act
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Carros para Locação'
    # Assert
    expect(page).to have_content car.car_identification
  end
end
