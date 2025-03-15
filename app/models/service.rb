class Service < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :prices
  has_many :vehicle_types, through: :prices

  validates :name, presence: true
  validates :duration, presence: true
end
