class ProductTank < ApplicationRecord
  validates :serial, presence: true, length: { minimum: 4, maximum: 20 }, uniqueness: true
  validates :weight, presence: true, length: { minimum: 1, maximum: 8 }
  validates :capacity, presence: true, length: { minimum: 1, maximum: 8 }
  validates :inspection_date, presence: true, length: { minimum: 6, maximum: 6 }
end
