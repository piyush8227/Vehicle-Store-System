# frozen_string_literal: true

module Build
  class DatabaseBuilder
    def reset_data
      User.destroy_all
      Manufacturer.destroy_all
      Vehicle.destroy_all
    end

    def create_users
      User.create!(first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   email: 'piyush@us.com',
                   age: Faker::Number.digit,
                   date_of_birth: Faker::Date.birthday,
                   password: '123456')
    end

    def create_vehicles
      40.times do
        Vehicle.create!(vehicle_model: Faker::Vehicle.unique.model,
                        year_of_manufacture: Faker::Vehicle.year,
                        fuel_type: Faker::Vehicle.fuel_type,
                        vehicle_type: Faker::Vehicle.car_type,
                        color: Faker::Vehicle.color,
                        mileage: Faker::Number.between(from: 6, to: 45),
                        max_speed: Faker::Number.between(from: 90, to: 250),
                        price: Faker::Number.number(digits: 6),
                        status: 'available',
                        manufacturer_id: Manufacturer.all.sample.id)
      end
    end

    def create_manufacturers
      20.times do
        Manufacturer.create!(manufacturer_name: Faker::Vehicle.manufacture)
      end
    end

    def execute
      reset_data
      create_users
      create_manufacturers
      create_vehicles
    end

    def run
      execute
    end
  end
end
