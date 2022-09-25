# frozen_string_literal: true

FactoryBot.define do
  factory(:vehicle) do
    vehicle_model { Faker::Lorem.unique.word }
    year_of_manufacture { Faker::Vehicle.year }
    fuel_type { Faker::Vehicle.fuel_type }
    vehicle_type { Faker::Vehicle.car_type }
    color { Faker::Vehicle.color }
    mileage { Faker::Number.between(from: 6, to: 45) }
    max_speed { Faker::Number.between(from: 90, to: 250) }
    price { Faker::Number.number(digits: 6) }
    status { 'available' }
    manufacturer

    trait :with_sold_status do
      status { :sold }
    end
  end
end
