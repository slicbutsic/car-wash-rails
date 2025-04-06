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

  validate :booking_does_not_overlap

  after_create :send_notifications

  private

  def booking_does_not_overlap
    return if booking_datetime.blank? || service.blank?

    new_start = booking_datetime
    new_end = booking_datetime + service.duration.minutes

    Booking.includes(:service).where.not(id: id).find_each do |existing_booking|
      existing_start = existing_booking.booking_datetime
      existing_end = existing_start + existing_booking.service.duration.minutes

      if (new_start < existing_end) && (new_end > existing_start)
        errors.add(:booking_datetime, "overlaps with another booking.")
        break
      end
    end
  end

  def send_notifications
    # Send confirmation email to the user
    BookingMailer.booking_confirmation(self).deliver_later

    # Send notification email to the admin
    BookingMailer.admin_notification(self).deliver_later
  end

end
