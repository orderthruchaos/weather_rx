require 'rest-client'

module VendorClient
  class BaseClient
    attr_reader address

    def initialize(address)
      @address = address
    end

    def get(url, params = {})
      RestClient.get(url, { **headers, params: params })
    end

    def headers
      headers = { accept: content_type }
      headers["user-agent"] = user_agent if user_agent

      headers
    end

    def content_type
      :json
    end

    def user_agent
      nil
    end
  end
end
