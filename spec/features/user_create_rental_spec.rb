require 'rails_helper'

feature 'User create rental' do
  scenario 'successfully' do
    car = create(:car)
    client = create(:client)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Locações'
    click_on 'Nova Locação'
    select client.name, from: 'Cliente'
    select car.car_model.car_category.name, from: 'Categoria'
    fill_in 'Data da Locação', with: Date.current.strftime('%d/%m/%y')
    fill_in 'Data final', with: 10.days.from_now.strftime('%d/%m/%y')
    click_on 'Enviar'
    # Assert
    expect(page).to have_content(client.name)
    expect(page).to have_content(car.car_model.car_category.name)
    expect(page).to have_content(Date.current.strftime('%d/%m/%y'))
    expect(page).to have_content(10.days.from_now.strftime('%d/%m/%y'))
    expect(page).to have_content('Locação agendada com sucesso')
  end

  scenario 'failed' do
    car = create(:car)
    client = create(:client)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Locações'
    click_on 'Nova Locação'
    select client.name, from: 'Cliente'
    select car.car_model.car_category.name, from: 'Categoria'
    fill_in 'Data da Locação', with: 10.days.ago.strftime('%d/%m/%y')
    fill_in 'Data final', with: ''
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Data Final da Locação não pode ficar em branco')
  end

  scenario 'Validates car exist' do
    car_category = create(:car_category)
    client = create(:client)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Locações'
    click_on 'Nova Locação'
    select client.name, from: 'Cliente'
    select car_category.name, from: 'Categoria'
    fill_in 'Data da Locação', with: Date.current.strftime('%d/%m/%y')
    fill_in 'Data final', with: 10.days.from_now.strftime('%d/%m/%y')
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Não existem carros disponíveis desta categoria')
  end

  scenario 'validates dates in past' do
    car = create(:car)
    client = create(:client)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Locações'
    click_on 'Nova Locação'
    select client.name, from: 'Cliente'
    select car.car_model.car_category.name, from: 'Categoria'
    fill_in 'Data da Locação', with: '01/01/1900'
    fill_in 'Data final', with: '01/01/1800'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Data final não pode ser antes da data inicial')
    expect(page).to have_content('Data inicial não pode ser antes de hoje')
  end
end
