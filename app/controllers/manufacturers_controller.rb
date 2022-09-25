# frozen_string_literal: true

class ManufacturersController < ApplicationController
  def new; end

  def index
    @manufacturers = Manufacturer.all.paginate(page: params[:page], per_page: 10)
  end

  def create
    @manufacturer = Manufacturer.new(manufacturers_params)
    if @manufacturer.save
      redirect_to root_path, notice: 'New manufacture is been added'
    else
      redirect_to new_manufacturer_path, alert: @manufacturer.errors.full_messages
    end
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.vehicles.present?
      @vehicles = @manufacturer.vehicles.available
      @min_mileage = @vehicles.find_by(mileage: @vehicles.minimum(:mileage)).vehicle_model
      @max_mileage = @vehicles.find_by(mileage: @vehicles.maximum(:mileage)).vehicle_model
      @min_price = @vehicles.find_by(price: @vehicles.minimum(:price)).vehicle_model
      @max_price = @vehicles.find_by(price: @vehicles.maximum(:price)).vehicle_model
      @max_top_speed = @vehicles.find_by(max_speed: @vehicles.maximum(:max_speed)).vehicle_model
    else
      redirect_to root_path, notice: 'No vehicles record for this manufacturer'
    end
  end

  private

  def manufacturers_params
    params.permit(:manufacturer_name)
  end
end
