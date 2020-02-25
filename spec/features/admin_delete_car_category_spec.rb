require 'rails_helper'

feature 'admin delete car category' do
  scenario 'succesfully' do
    # Arrange
    car_category = create(:car_category)
    # Act
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de Carros'
    click_on car_category.name
    click_on 'Apagar'
    # Assert
    expect(page).to have_no_content(car_category.name)
    expect(page).to have_content('Categoria apagada com sucesso')
  end
end
