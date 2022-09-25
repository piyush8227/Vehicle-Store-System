# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_model
      t.integer :year_of_manufacture
      t.string :fuel_type
      t.string :vehicle_type
      t.string :color
      t.integer :mileage
      t.integer :max_speed
      t.integer :price
      t.integer :manufacturer_id
      t.string :status, default: 'available'

      t.timestamps
    end
  end
end
