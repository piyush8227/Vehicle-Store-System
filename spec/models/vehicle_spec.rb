# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let(:manufacturer) { create(:manufacturer) }
  context 'model attributes presence' do
    it 'must have all vehicle attributes' do
      vehicle = Vehicle.new(vehicle_model: Faker::Vehicle.model,
                            year_of_manufacture: Faker::Vehicle.year,
                            fuel_type: Faker::Vehicle.fuel_type,
                            vehicle_type: Faker::Vehicle.car_type,
                            color: Faker::Vehicle.color,
                            mileage: Faker::Number.between(from: 6, to: 45),
                            max_speed: Faker::Number.between(from: 90, to: 250),
                            price: Faker::Number.number(digits: 6),
                            status: 'available',
                            manufacturer_id: manufacturer.id).save
      expect(vehicle).to eq(true)
    end
  end
end
