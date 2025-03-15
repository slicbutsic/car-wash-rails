class VehicleType < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :prices, dependent: :destroy

  validates :name, presence: true
end
