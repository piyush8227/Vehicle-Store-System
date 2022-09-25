# frozen_string_literal: true

require 'rails_helper'

feature 'Vehicles detail page' do
  let(:user) { create(:user) }
  let!(:vehicles) { create_list(:vehicle, 9) }
  def login_credentials
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
  end

  def visit_page
    visit new_user_session_path
    login_credentials
    click_button 'Log in'
  end

  scenario 'checks for vehicles details page' do
    visit_page
    click_link 'List of Vehicles'
    expect(page).to have_css('table')
    within 'table' do
      click_link vehicles.last.vehicle_model
    end
    expect(page).to have_text("Max Speed (Kmph): #{vehicles.last.max_speed}")
    expect(page).to have_text("Color: #{vehicles.last.color}")
    expect(page).to have_button('Sell')
  end
end
