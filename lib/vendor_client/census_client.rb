require_relative "base_client"

module VendorClient
  class CensusClient < BaseClient
    # Benchmark "current" has ID = 4
    BENCHMARK = 4
    ADDRESS_ENDPOINT = "https://geocoding.geo.census.gov/geocoder/locations/address"

    def location
      @location ||= get(url, params: params)
    end

    def coordinates
      location["result"]["addressMatches"][0]["coordinates"]
    end

    def latitude
      coordinates["y"]
    end

    def longitude
      coordinates["x"]
    end

    def url
      ADDRESS_ENDPOINT
    end

    def params
      {
        benchmark: BENCHMARK,
        format: "json",
        street: address.line_1,
        city: address.city,
        state: address.state.abbreviation,
        zip: address.zip_code.code
      }
    end
  end
end
