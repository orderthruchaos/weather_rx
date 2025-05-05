require_relative "base_client"

module VendorClient
  class NwsClient < BaseClient
    # def content_type
    #   "application/geo+json"
    # end

    def metadata_url
      "https://api.weather.gov/points/#{latitude},#{longitude}"
    end

    def metadata
      @metadata ||= get(metadata_url, cache_key: metadata_cache_key)
    end

    def metadata_cache_key
      @metadata_cache_key ||= "#{self.class.name}/metadata/#{address.id}"
    end

    def forecast_url
      @forecast_url ||= metadata["properties"]["forecast"]
    end

    def forecast
      @forecast ||= get(forecast_url, cache_key: forecast_cache_key, cache_expires: 30.minutes.to_i)
    end

    def forecast_cache_key
      @forecast_cache_key ||= "#{self.class.name}/forecast/#{address.zip_code.id}"
    end

    def hourly_forecast_url
      @hourly_forecast_url ||= metadata["properties"]["forecastHourly"]
    end

    def hourly_forecast
      @hourly_forecast ||= get(hourly_forecast_url, cache_key: hourly_forecast_cache_key, cache_expires: 30.minutes.to_i)
    end

    def hourly_forecast_cache_key
      @hourly_forecast_cache_key ||= "#{self.class.name}/hourly_forecast/#{address.zip_code.id}"
    end

    def latitude
      # # TODO
      # 38.8894
      address&.latitude
    end

    def longitude
      # # TODO
      # -77.0352
      address&.longitude
    end

    def user_agent
      "(#{user_agent_host}, #{user_agent_email})"
    end

    def user_agent_host
      ENV.fetch("NWS_API_USER_AGENT_HOST") { "example.com" }
    end

    def user_agent_email
      ENV.fetch("NWS_API_USER_AGENT_EMAIL") { "no-reply@example.com" }
    end
  end
end
