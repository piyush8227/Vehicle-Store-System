# frozen_string_literal: true

require 'rails_helper'

feature 'Create manufacturer' do
  let(:user) { create(:user) }

  def login_credentials
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
  end

  def visit_page
    visit new_user_session_path
    login_credentials
    click_button 'Log in'
    click_link 'Add Manufacturer'
  end

  scenario 'checks if manufacturer is created or not ' do
    visit_page
    fill_in 'manufacturer_name', with: Faker::Vehicle.manufacture
    click_button 'Create Manufacturer'
    expect(page).to have_content('New manufacture is been added')
  end

  scenario 'checks for null input' do
    visit_page
    fill_in 'manufacturer_name', with: nil
    click_button 'Create Manufacturer'
    expect(page).to have_content("Manufacturer name can't be blank")
  end
end
