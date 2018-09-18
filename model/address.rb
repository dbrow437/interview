class Address < ActiveRecord::Base
  attr_accessor :addtess, :latitude, :longitude
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
