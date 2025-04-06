class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @service = Service.find(params[:service_id])
    @vehicle_types = VehicleType.all

    # If a vehicle type is selected, calculate the price
    if params[:booking] && params[:booking][:vehicle_type_id].present?
      vehicle_type = VehicleType.find(params[:booking][:vehicle_type_id])
      @price = Price.find_by(service_id: @service.id, vehicle_type_id: vehicle_type.id)
    end
  end

  def create
    date = Date.strptime(booking_params[:booking_datetime], "%d-%m-%Y")
    time = booking_params[:booking_time]
    datetime = Time.zone.parse("#{date} #{time}")

    @service = Service.find(params[:booking][:service_id])
    @vehicle_type = VehicleType.find(params[:booking][:vehicle_type_id])
    @price = Price.find_by(service_id: @service.id, vehicle_type_id: @vehicle_type.id)

    # Build the booking with merged datetime
    @booking = Booking.new(booking_params.except(:booking_time).merge(
      booking_datetime: datetime,
      service: @service,
      vehicle_type: @vehicle_type,
      price: @price,
      user: current_user
    ))

    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking successfully created!"
    else
      @vehicle_types = VehicleType.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: 'Booking was successfully deleted.'
  end

  def unavailable_times
    date = Date.strptime(params[:date], "%d-%m-%Y")
    bookings = Booking.includes(:service).where(
      booking_datetime: date.beginning_of_day..date.end_of_day
    )

    times = bookings.map do |booking|
      start_time = booking.booking_datetime
      end_time = start_time + booking.service.duration.minutes
      {
        start: start_time.strftime("%H:%M"),
        end: end_time.strftime("%H:%M"),
        duration: booking.service.duration
      }
    end

    render json: { unavailable: times }
  end

  private

  def booking_params
    params.require(:booking).permit(:phone, :service_id, :vehicle_type_id, :booking_datetime, :booking_time).merge(user_id: current_user.id)
  end
end
