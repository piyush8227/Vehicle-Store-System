# frozen_string_literal: true

require 'rails_helper'

feature 'List of vehicles' do
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

  scenario 'checks if vehicles table ' do
    visit_page
    click_link 'List of Vehicles'
    expect(page).to have_css('table')
  end

  scenario 'checks if vehicles attributes are present or not ' do
    visit_page
    click_link 'List of Vehicles'
    expect(page).to have_css('table')
    within 'table' do
      expect(page).to have_text(vehicles.first.vehicle_model)
      expect(page).to have_text(vehicles.last.vehicle_type)
      expect(page).to have_text(vehicles.first.color)
    end
  end
end
