class Game < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :rounds
end
