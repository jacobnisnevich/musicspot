require 'GoogleMapsAPI'
require 'search/DistanceSort'
require 'search/TimeSort'
require 'will_paginate/array'

class EventsController < ApplicationController
  def home
    if params[:name].blank?
      @events = Event.all.to_a
    else
      @events = Event.where("lower(name) LIKE ?", "%#{params[:name].downcase}%").to_a
    end

    if !(params[:zip].blank?)
      destinations_zips = @events.map { |e| e.location }
      @destinations = GoogleMapsAPI.get_distances(params[:zip], destinations_zips)
      @strategy = params[:search]
      if params[:search] == "distance"
        strategy = DistanceSort.new
      else
        strategy = TimeSort.new
      end
      @events = strategy.sort(@events, @destinations)
    end
    @num_results = @events.size
    @events = @events.paginate(page: params[:page], :per_page => 10)
  end

  def new
    @full_width = true
    @event = Event.new
    @group_id = params[:id]

    @group = Group.find(@group_id)
    @group_admins = @group.admin_users

    @group_availability = Array.new(168, 0)
    @group.users.each do |user|
      for i in 0..167 do
        if user.profile.availability[i] == "1"
          @group_availability[i] += 1
        end
      end
    end

    @max_people = @group_availability.max
    max_index = @group_availability.index(@max_people)
    @best_day = Date::DAYNAMES[max_index / 24]
    hour = max_index % 24
    if hour == 0
      @best_hour = "12:00 AM"
    elsif hour == 12
      @best_hour = "12:00 PM"
    elsif hour < 12
      @best_hour = hour.to_s + ":00 AM"
    else
      @best_hour = (hour - 12) + ":00 PM"
    end

  end

  def submit
    @event = Event.new(event_params)
    @event.groups << Group.find_by(id: params[:id])

    if (@event.save)
      redirect_to '/events'
    else
      render 'new'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def add_user
    if current_user
      @event = Event.find_by(id: params[:event_id])
      @event.users << current_user unless @event.users.include?(current_user)
      if (@event.save)
        redirect_back fallback_location: { action: 'show', id: @event.id }
      end
    end
  end

  def remove_user
    if current_user
      @event = Event.find_by(id: params[:event_id])
      @event.users.delete(current_user)
      if (@event.save)
        redirect_back fallback_location: { action: 'show', id: @event.id }
      end
    end
  end

  private

    def event_params
      params.require(:event).permit(:end_datetime, :name, :location, :description, :start_datetime, :image)
    end
end
