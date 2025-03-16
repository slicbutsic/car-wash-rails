class CombineBookingDateAndTime < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :booking_date
    remove_column :bookings, :booking_time
    add_column :bookings, :booking_datetime, :datetime
  end
end
