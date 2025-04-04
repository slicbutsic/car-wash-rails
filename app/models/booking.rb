class Booking < ApplicationRecord
  belongs_to :service
  belongs_to :vehicle_type
  belongs_to :user
  belongs_to :price

  validates :phone, format: { with: /\A04[0-9]{2}[- ]?[0-9]{3}[- ]?[0-9]{3}\z/, message: "must be a valid Australian phone number" }, presence: true
  validates :vehicle_type_id, presence: true
  validates :service_id, presence: true
  validates :user_id, presence: true
  validates :booking_datetime, presence: true

  after_create :send_notifications

  private

  def send_notifications
    # Send confirmation email to the user
    BookingMailer.booking_confirmation(self).deliver_later

    # Send notification email to the admin
    BookingMailer.admin_notification(self).deliver_later
  end

end
