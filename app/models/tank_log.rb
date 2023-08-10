class TankLog < ApplicationRecord
  validates :serial, presence: true, length: { minimum: 4, maximum: 20 }
end
