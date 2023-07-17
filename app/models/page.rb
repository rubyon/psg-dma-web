class Page < ApplicationRecord
  has_many :titles
  has_many :digitals
  has_many :analogs
  has_many :gauges
end
