class ProductTank < ApplicationRecord
  validates :serial, presence: true, length: { is: 16 }, uniqueness: true
  validates :weight, presence: true, length: { minimum: 1, maximum: 6 }
  validates :capacity, presence: true, length: { minimum: 1, maximum: 4 }
  validates :inspection_date, presence: true, length: { minimum: 6, maximum: 6 }
end
