require 'soundcloud'

class SoundCloudAPI
  include HTTParty
  format :json

  attr_accessor :embed_tracks

  def initialize(embed_tracks)
    @embed_tracks = embed_tracks
  end

  def self.get_tracks(soundcloud_url)
    soundloud_user = /.*soundcloud\.com\/(.*)/.match(soundcloud_url)[1]
    client = SoundCloud.new(:client_id => '02gUJC0hH2ct1EGOcYXQIzRFU91c72Ea')

    tracks = client.get("/users/#{soundloud_user}/tracks")

    track_urls = tracks.map {|track| track.permalink_url }
    track_dates = tracks.map {|track| Date.parse(track.last_modified) }

    embed_tracks = []

    track_urls.each_with_index do |track_url, index|
      embed_info = client.get('/oembed', :url => track_url)

      embed_tracks.push({
        date: track_dates[index],
        embed_html: embed_info['html']
      })
    end

    new(embed_tracks)
  end
end
