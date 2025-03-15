class BookingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @service = Service.find(params[:service_id])
    @booking = Booking.new

    @vehicle_types = VehicleType.all
  end

  def create
    @service = Service.find(params[:booking][:service_id])
    @booking = @service.bookings.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking successfully created!"
    else
      render :new
    end
  end


  # def create
  #   @service = Service.find(params[:booking][:service_id])
  #   @vehicle_type = VehicleType.find(params[:booking][:vehicle_type_id])

  #   # Find the price based on the service and vehicle type
  #   @price = Price.find_by(service: @service, vehicle_type: @vehicle_type)

  #   @booking = @service.bookings.new(booking_params)
  #   @booking.price = @price.price # Set the price to the booking

  #   if @booking.save
  #     redirect_to booking_path(@booking), notice: "Booking successfully created!"
  #   else
  #     render :new
  #   end
  # end

  private

  def booking_params
    params.require(:booking).permit(:phone, :service_id, :vehicle_type_id, :booking_date, :booking_time).merge(user_id: current_user.id)
  end
end
