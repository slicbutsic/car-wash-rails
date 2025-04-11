class ServicesController < ApplicationController
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @services = Service.includes(:prices).all
  end

  def new
    @service = Service.new
    @vehicle_types = VehicleType.all
  end

  def create
    @service = Service.new(service_params.except(:prices))
    if @service.save
      prices_params = service_params[:prices] || {}
      prices_params.each do |vehicle_type_id, price_value|
        @service.prices.create!(
          vehicle_type_id: vehicle_type_id,
          price: price_value
        )
      end
      redirect_to services_path, notice: 'Service created successfully.'
    else
      @vehicle_types = VehicleType.all
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
    @vehicle_types = VehicleType.all
  end

  def update
    @service = Service.find(params[:id])

    ActiveRecord::Base.transaction do
      if @service.update(service_params.except(:prices)) 
        update_prices(@service)
        redirect_to services_path, notice: 'Service updated successfully.'
      else
        render :edit
      end
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to services_path, notice: 'Service deleted successfully.'
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :duration, prices: {})
  end

  def authenticate_admin!
    unless current_user && current_user.email == "admin@gmail.com"
      redirect_to root_path, alert: "You are not authorised to access this page."
    end
  end

  def update_prices(service)
    # For each price entry in the form
    service_params[:prices].each do |vehicle_type_id, price_value|
      # Find or initialize a price record for the specific vehicle_type_id
      price = service.prices.find_or_initialize_by(vehicle_type_id: vehicle_type_id)

      # Update the price
      price.update!(price: price_value)
    end
  end
end
