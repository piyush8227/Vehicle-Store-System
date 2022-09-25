# frozen_string_literal: true

require 'rails_helper'

feature 'List of manufacturer' do
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
    click_link 'Report of manufacturers'
  end

  scenario 'checks if manufacturer table' do
    visit_page
    expect(page).to have_css('table')
  end

  scenario 'checks if manufacturer table & attributes are present or not ' do
    visit_page
    expect(page).to have_css('table')
    within 'table' do
      expect(page).to have_text(manufacturers.first.manufacturer_name)
    end
  end
end
