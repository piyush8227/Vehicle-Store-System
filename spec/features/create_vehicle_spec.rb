# frozen_string_literal: true

require 'rails_helper'

feature 'Create vehicle' do
  let(:user) { create(:user) }
  let!(:manufacturers) { create_list(:manufacturer, 9) }
  def login_credentials
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
  end

  def visit_page
    visit new_user_session_path
    login_credentials
    click_button 'Log in'
    click_link 'Add Vehicle'
  end

  def vehicle_details
    fill_in 'vehicle_model', with: Faker::Vehicle.model
    fill_in 'year_of_manufacture', with: Faker::Vehicle.year
    fill_in 'fuel_type', with: Faker::Vehicle.fuel_type
    fill_in 'vehicle_type', with: Faker::Vehicle.car_type
    fill_in 'color', with: Faker::Vehicle.color
    fill_in 'mileage', with: Faker::Number.between(from: 6, to: 45)
    fill_in 'max_speed', with: Faker::Number.between(from: 90, to: 250)
    fill_in 'price', with: Faker::Number.number(digits: 6)
    manufacturer = page.find('select#manufacturer_id')
    manufacturer.select manufacturers.last.manufacturer_name
  end

  scenario 'checks if vehicle is created or not ' do
    visit_page
    vehicle_details
    click_button 'Create Vehicle'
    expect(page).to have_content('New vehicle is added')
  end

  scenario 'checks for null inputs' do
    visit_page
    fill_in 'vehicle_model', with: nil
    fill_in 'year_of_manufacture', with: nil
    fill_in 'fuel_type', with: nil
    fill_in 'vehicle_type', with: nil
    fill_in 'color', with: nil
    fill_in 'mileage', with: nil
    fill_in 'max_speed', with: nil
    fill_in 'price', with: nil
    click_button 'Create Vehicle'
    expect(page).to have_content("Vehicle model can't be blank")
    expect(page).to have_content("Vehicle type can't be blank")
    expect(page).to have_content("Fuel type can't be blank")
    expect(page).to have_content("Color can't be blank")
    expect(page).to have_content("Year of manufacture can't be blank")
    expect(page).to have_content("Mileage can't be blank")
    expect(page).to have_content("Max speed can't be blank")
    expect(page).to have_content("Price can't be blank")
  end
end
