# frozen_string_literal: true

class Manufacturer < ApplicationRecord
  validates :manufacturer_name, presence: true

  has_many :vehicles
end
