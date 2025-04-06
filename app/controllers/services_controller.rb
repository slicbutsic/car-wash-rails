class ServicesController < ApplicationController
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @services = Service.includes(:prices).all
  end

  def edit
    @service = Service.find(params[:id])
    @vehicle_types = VehicleType.all
  end

  def update
    @service = Service.find(params[:id])

    # Begin transaction to ensure both service and price updates happen atomically
    ActiveRecord::Base.transaction do
      if @service.update(service_params)
        update_prices(@service) # Update prices based on new service data
        redirect_to services_path, notice: 'Service updated successfully.'
      else
        render :edit
      end
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :duration)
  end

  def authenticate_admin!
    # Add your logic here to authenticate that the user is an admin
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
