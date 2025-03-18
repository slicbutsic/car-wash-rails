class Booking < ApplicationRecord
  belongs_to :service
  belongs_to :vehicle_type
  belongs_to :user
  belongs_to :price

  validates :phone, presence: true
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
