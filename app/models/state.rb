class State < ApplicationRecord
  has_many :addresses, dependent: :destroy
end
