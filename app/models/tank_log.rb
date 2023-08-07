class TankLog < ApplicationRecord
  validates :serial, presence: true, length: { is: 16 }
end
