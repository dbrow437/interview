require 'sinatra/base'
require 'Geocoder'
Dir['./lib/*.rb'].each { |f| require f }


class Main < Sinatra::Base
  get '/' do
    distance = Distance.new
    results = distance.results

    erb :index, locals: { results: results }
  end
end

class Distance
  # set constant variable of an array of coordinates

  COORDINATES = [
    [61.582195, -149.443512],
    [44.775211, -68.774184],
    [25.891297, -97.393349],
    [45.787839, -108.502110],
    [35.109937, -89.959983]
  ]

  # aset constant variable of an array of white house coordinates
  WHITE_HOUSE = [38.8977, 77.0365]

  # address takes in [lat, long] coordinates and returns the first address found by geocoder
  def address(coordinates)
    Geocoder.search(coordinates).first.address
  end

  # distance takes in [lat, long] coordinates from and to locations and calculates the distance between points in miles
  def distance(from, to)
    Geocoder::Calculations.distance_between(from, to)
  end

  # results maps coordinates and returns an object with address and distance and then sorts in ascending order
  def results
    results = COORDINATES.map { |c| { address: address(c), distance: distance(c, WHITE_HOUSE) } }
    results.sort { |x,y| x[:distance] <=> y[:distance] }
  end
end
