class Price < ApplicationRecord
  belongs_to :service
  belongs_to :vehicle_type

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :service_id, presence: true
  validates :vehicle_type_id, presence: true
end
