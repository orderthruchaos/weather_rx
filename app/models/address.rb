class Address < ApplicationRecord
  belongs_to :state
  belongs_to :zip_code

  validates :line_1, presence: true
  validates :city, presence: true

  validates :state, presence: true
  validates :zip_code, presence: true
end
