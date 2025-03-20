class ServicesController < ApplicationController
  def index
    @services = Service.includes(:prices).all
  end
end
