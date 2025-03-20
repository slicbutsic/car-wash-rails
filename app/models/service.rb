class Service < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :prices
  has_many :vehicle_types, through: :prices

  validates :name, presence: true
  validates :duration, presence: true


  def formatted_duration
    if duration.present?
      hours = duration / 60
      minutes = duration % 60
      if duration >= 60
        "#{hours}h #{minutes}min"
      else
        "#{duration} minutes"
      end
    end
  end

end
