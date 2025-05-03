class ZipCode < ApplicationRecord
  has_many :addresses, dependent: :destroy

  validates :code,
    length: { is: 5 },
    format: { with: /\A\d{5}\z/,
              message: "must be five digits" }
end
