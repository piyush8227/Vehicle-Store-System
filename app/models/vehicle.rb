# frozen_string_literal: true

class Vehicle < ApplicationRecord
  include AASM

  belongs_to :manufacturer

  validates :vehicle_model, :vehicle_type, :fuel_type, :color, :year_of_manufacture, :mileage, :max_speed, :price, presence: true

  validates_numericality_of :year_of_manufacture, :mileage, :max_speed, :price, only_integer: true, greater_than_or_equal_to: 0

  scope :order_by_manufacture_name, -> { includes(:manufacturer).references(:manufacturer).order('manufacturer_name DESC') }

  scope :filter_by_status, ->(status) { where status: status }

  aasm column: :status do
    state :available, initial: true
    state :sold

    event :sell_vehicle do
      transitions from: :available, to: :sold
    end

    event :avail_vehicle do
      transitions from: :sold, to: :available
    end
  end
end
