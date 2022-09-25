# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :find_vehicle, only: %i[show sold]
  def new; end

  def index
    @vehicles = Vehicle.all.order(params[:sort]).paginate(page: params[:page], per_page: 10)
    @vehicles = @vehicles.filter_by_status(params[:status]) if params[:status].present?
    @vehicles = @vehicles.order_by_manufacture_name if params[:sort] == 'manufacturer_name'
  end

  def create
    @vehicle = Vehicle.new(vehicles_params)
    if @vehicle.save
      redirect_to root_path, notice: 'New vehicle is added'
    else
      redirect_to new_vehicle_path, alert: @vehicle.errors.full_messages
    end
  end

  def show; end

  def sold
    if @vehicle.available?
      @vehicle.sell_vehicle!
      redirect_to vehicle_path, notice: 'Sold'
    else
      redirect_to vehicle_path, notice: 'Already sold'
    end
  end

  private

  def find_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicles_params
    params.permit(:vehicle_model, :year_of_manufacture, :fuel_type, :vehicle_type, :color, :mileage, :max_speed, :price, :status, :manufacturer_id)
  end
end
