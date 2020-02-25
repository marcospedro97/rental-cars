# frozen_string_literal: true

require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    # Arrange
    subsidiary = create(:subsidiary)
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Filiais'
    click_on subsidiary.name
    # Assert
    expect(page).to have_content(subsidiary.name)
    expect(page).to have_content(subsidiary.cnpj)
    expect(page).to have_content(subsidiary.address)
  end

  scenario 'and view subsidiaries links' do
    subsidiary = create(:subsidiary)
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
    # Assert
    expect(page).to have_link(subsidiary.name)
  end

  scenario 'and subsidiaries are not registered' do
    # Arrange
    user = create(:user)
    login_as user, scope: :user
    # Act
    visit root_path
    click_on 'Filiais'
    # Assert
    expect(page).to have_content('Não existem filiais ' \
                                'cadastradas no sistema.')
  end
  scenario 'and must be authenticated via route' do
    # Act
    visit subsidiaries_path
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end
end
