class Booking < ApplicationRecord
  belongs_to :service
  belongs_to :vehicle_type
  belongs_to :user
end
