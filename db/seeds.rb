# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'
require 'pp'

STATE_NAMES_PATH = File.join(Rails.root, 'db', 'data', 'us_states_and_territories.csv')

CSV.foreach(STATE_NAMES_PATH, headers: true, header_converters: :symbol) do |row|
  pp State.find_or_create_by!(abbreviation: row[:abbreviation], name: row[:name])
end
