require_relative 'base_client'

module VendorClient
  class NwsClient < BaseClient
    # def content_type
    #   "application/geo+json"
    # end

    def metadata_url
      "https://api.weather.gov/points/#{latitude},#{longitude}"
    end

    def metadata
      @metadata ||= get(metadata_url)
    end

    def forecast_url
      @forecast_url ||= metadata["properties"]["forecast"]
    end

    def forecast
      @forecast ||= get(forecast_url)
    end

    def hourly_url
      @hourly_url ||= metadata["properties"]["forecastHourly"]
    end

    def hourly
      @hourly ||= get(hourly_url)
    end

    def latitude
      # # TODO
      # address.latitude
      38.8894
    end

    def longitude
      # # TODO
      # address.longitude
      -77.0352
    end

    def user_agent
      "(#{user_agent_host}, #{user_agent_email})"
    end

    def user_agent_host
      ENV.fetch('NWS_API_USER_AGENT_HOST') { 'example.com' }
    end

    def user_agent_email
      ENV.fetch('NWS_API_USER_AGENT_EMAIL') { 'no-reply@example.com' }
    end
  end
end
