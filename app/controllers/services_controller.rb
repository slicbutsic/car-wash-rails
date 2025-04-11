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
    @service = Service.new(service_params)
    if @service.save
      # You might want to initialize prices for each vehicle type here
      VehicleType.all.each do |vt|
        @service.prices.create(vehicle_type: vt, price: 0.0)
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
      if @service.update(service_params)
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
    params.require(:service).permit(:name, :description, :duration)
  end

  def authenticate_admin!
    unless current_user && current_user.email == "admin@gmail.com"
      redirect_to root_path, alert: "You are not authorised to access this page."
    end
  end

  def update_prices(service)
    service.prices.each do |price|
      new_price = params[:service][:prices][price.vehicle_type.id.to_s]
      price.update!(price: new_price)
    end
  end
end
