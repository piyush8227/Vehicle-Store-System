# frozen_string_literal: true

require 'rails_helper'

feature 'List of manufacturer' do
  let(:user) { create(:user) }
  let!(:manufacturers) { create_list(:manufacturer, 9) }
  let!(:vehicles) { create_list(:vehicle, 9, manufacturer_id: manufacturers.first.id) }
  def login_credentials
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
  end

  def visit_page
    visit new_user_session_path
    login_credentials
    click_button 'Log in'
    click_link 'Report of manufacturers'
  end

  scenario 'report of a manufacturer' do
    visit_page
    within 'table' do
      click_link manufacturers.first.manufacturer_name
    end
    @vehicles = manufacturers.first.vehicles

    min_mileage = @vehicles.find_by(mileage: @vehicles.minimum(:mileage)).vehicle_model
    max_mileage = @vehicles.find_by(mileage: @vehicles.maximum(:mileage)).vehicle_model
    min_price = @vehicles.find_by(price: @vehicles.minimum(:price)).vehicle_model
    max_price = @vehicles.find_by(price: @vehicles.maximum(:price)).vehicle_model
    max_top_speed = @vehicles.find_by(max_speed: @vehicles.maximum(:max_speed)).vehicle_model

    expect(page).to have_text("Vehicle with the min mileage: #{min_mileage}")
    expect(page).to have_text("Vehicle with the max mileage: #{max_mileage}")
    expect(page).to have_text("Cheapest vehicle: #{min_price}")
    expect(page).to have_text("Most expensice vehicle: #{max_price}")
    expect(page).to have_text("Vehicle with the Max Top Speed: #{max_top_speed}")
  end
end
