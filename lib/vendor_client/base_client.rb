require 'rest-client'

module VendorClient
  class BaseClient
    attr_reader :address

    def initialize(address)
      @address = address
    end

    def get(url, params: {}, cache_key: nil, cache_expires: 2.weeks.to_i)
      cache_key ||= default_cache_key
      Rails.cache.fetch(cache_key, expires_in: cache_expires) do
        RestClient.get(url, { **headers, params: params })
      end
    end

    def headers
      headers = { accept: content_type }
      headers["user-agent"] = user_agent if user_agent

      headers
    end

    def default_cache_key
      "#{self.class.name}/get/#{address.id}"
    end

    def content_type
      :json
    end

    def user_agent
      nil
    end
  end
end
