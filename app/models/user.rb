# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :date_validator
  def date_validator
    errors.add(:date_of_birth, 'cannot be greater than current date') if date_of_birth.present? && Date.current < date_of_birth
  end
end
