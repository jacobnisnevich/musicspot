class EventsController < ApplicationController
  def home
    @events = Event.all.to_a
  end
end
