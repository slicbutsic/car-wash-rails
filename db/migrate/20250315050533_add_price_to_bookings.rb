class AddPriceToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :price, null: false, foreign_key: true
  end
end
