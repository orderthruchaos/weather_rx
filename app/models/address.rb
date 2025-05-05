class Address < ApplicationRecord
  belongs_to :state
  belongs_to :zip_code

  validates :line_1, presence: true
  validates :city, presence: true

  validates :state, presence: true
  validates :zip_code, presence: true

  delegate :latitude, to: :census_client
  delegate :location, to: :census_client
  delegate :longitude, to: :census_client

  def census_client
    @census_client ||= VendorClient::CensusClient.new(self)
  end

  def location
    @location ||= census_client.location
  end
end
