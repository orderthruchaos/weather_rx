class ForecastsController < ApplicationController
  before_action :set_address

  def forecast
    @forecast = nws_client.forecast
    Rails.logger.info(@forecast)
  end

  def hourly_forecast
    @hourly_forecast = nws_client.hourly_forecast
    Rails.logger.info(@hourly_forecast)
  end

  private

  def nws_client
    @nws_client ||= VendorClient::NwsClient.new(@address)
  end

  def set_address
    address_id = params.require(:address_id)
    @address = Address.find(address_id)
  end
end
