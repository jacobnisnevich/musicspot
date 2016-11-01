require 'httparty'

class GoogleMapsAPI
  include HTTParty
  format :json


  base_uri 'maps.googleapis.com/maps/api/distancematrix'

  attr_accessor :distances

  def initialize(response, destinations)
    @distances = {}
    @durations = {}

    response['rows'][0]['elements'].each_with_index do |destination, index|
      @distances[destinations[index]] = {
        :text => destination['distance']['text'],
        :value => destination['distance']['value']
      }

      @durations[destinations[index]] = {
        :text => destination['duration']['text'],
        :value => destination['duration']['value']
      }
    end
  end

  def self.get_distances(origin, destinations)
    response = get("/json?units=imperial&origins=#{origin}&destinations=#{destinations.join('|')}&key=#{ENV["wunderground_key"]}")
    if response.success?
      new(response, destinations)
    else
      raise response.response
    end
  end

end