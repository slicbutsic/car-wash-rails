class AddBookingDateAndBookingTimeToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :booking_date, :date
    add_column :bookings, :booking_time, :time
  end
end
