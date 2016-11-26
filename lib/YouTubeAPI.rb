require 'yt'

class YouTubeAPI
  attr_accessor :embed_videos

  def initialize(embed_videos)
    @embed_videos = embed_videos
  end

  def self.get_videos(youtube_url)
    Yt.configuration.api_key = ENV['YOUTUBE_API_KEY']

    channel = Yt::Channel.new(url: youtube_url)

    channel_videos = channel.videos.where(max_results: 5)
    video_embeds = channel_videos.map {|video| video.embed_html }
    video_dates = channel_videos.map {|video| Date.parse(video.snippet.data['publishedAt']) }
    
    embed_videos = []

    video_embeds.each_with_index do |video_embed, index|
      embed_videos.push({
        date: video_dates[index],
        embed_html: video_embed
      })
    end
    
    new(embed_videos)
  end
end
