class Address < ApplicationRecord
  belongs_to :state
  belongs_to :zip_code
end
