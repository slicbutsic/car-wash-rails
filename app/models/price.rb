class Price < ApplicationRecord
  belongs_to :service
  belongs_to :vehicle_type
end
