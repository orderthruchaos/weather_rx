class ZipCode < ApplicationRecord
  has_many :addresses, dependent: :destroy
end
