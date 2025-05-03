class State < ApplicationRecord
  has_many :addresses, dependent: :destroy

  validates :abbreviation,
    length: { is: 2 },
    format: { with: /\A[A-Z][A-Z]\z/,
              message: "only capital letters are allowed" }

  validates :name, presence: true
end
