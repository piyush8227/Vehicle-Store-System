# frozen_string_literal: true

FactoryBot.define do
  factory(:manufacturer) do
    manufacturer_name { Faker::Lorem.unique.word }
  end
end
