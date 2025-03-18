class BookingMailer < ApplicationMailer
  default from: 'siviglialucas@gmail.com'

  # Email to the user for booking confirmation
  def booking_confirmation(booking)
    @booking = booking
    mail(
      to: @booking.user.email, # User's email
      subject: "New Booking - #{@booking.service.name}"
    )
  end

  # Email to the admin about a new booking
  def admin_notification(booking)
    @booking = booking
    mail(
      to: 'siviglialucas@gmail.com', # Admin's email address
      subject: "Booking confirmation - #{@booking.service.name}"
    )
  end
end
