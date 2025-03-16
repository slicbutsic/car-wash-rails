class Booking < ApplicationRecord
  belongs_to :service
  belongs_to :vehicle_type
  belongs_to :user
  belongs_to :price

  validates :phone, presence: true
  validates :vehicle_type_id, presence: true
  validates :service_id, presence: true
  validates :user_id, presence: true
  validates :booking_date, presence: true
  validates :booking_time, presence: true
end
