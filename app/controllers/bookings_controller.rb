class BookingsController < ApplicationController
  before_action :authenticate_user!

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
    @service = Service.find(params[:booking][:service_id])
    @vehicle_type = VehicleType.find(params[:booking][:vehicle_type_id])
    @price = Price.find_by(service_id: @service.id, vehicle_type_id: @vehicle_type.id)

    @booking = @service.bookings.new(booking_params)
    @booking.price_id = @price.id if @price

    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking successfully created!"
    else
      @vehicle_types = VehicleType.all
      render :new
    end
  end





  private

  def booking_params
    params.require(:booking).permit(:phone, :service_id, :vehicle_type_id, :booking_datetime).merge(user_id: current_user.id)
  end
end
