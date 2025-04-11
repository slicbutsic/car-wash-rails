class Service < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :prices, dependent: :destroy
  has_many :vehicle_types, through: :prices

  validates :name, presence: true
  validates :duration, presence: true
  validates :description, presence: true
  

  def cheapest_price
    prices.minimum(:price)
  end

  def formatted_duration
    if duration.present?
      hours = duration / 60
      minutes = duration % 60
      if hours > 0
        # Show hours and minutes only if minutes are non-zero
        "#{hours}h #{minutes > 0 ? "#{minutes}min" : ''}"
      else
        # If hours are 0, only show minutes
        "#{minutes} minutes" unless minutes == 0
      end
    end
  end

end
