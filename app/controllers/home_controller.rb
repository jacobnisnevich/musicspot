class HomeController < ApplicationController
  def home
    if current_user
      groups = current_user.groups

      events = []
      announcements = []

      groups.each do |group|
        events.concat(group.events)
        announcements.concat(group.announcements)
      end

      @news = []

      events.each do |event|
        @news.push({
          type: 'event',
          post: event
        })
      end

      announcements.each do |announcement|
        @news.push({
          type: 'announcement',
          post: announcement
        })
      end

      @news = @news.sort_by { |news_post| news_post[:post].created_at }.reverse
    else
      render 'static_pages/home' unless current_user
    end
  end
end
