# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  context 'model attributes presence' do
    it 'must have Manufacturer name' do
      manufacturer = Manufacturer.new(manufacturer_name: Faker::Vehicle.manufacture).save
      expect(manufacturer).to eq(true)
    end
  end
end
