require 'GoogleMapsAPI'
require 'search/DistanceSort'
require 'search/TimeSort'

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
  end

  def new
    @full_width = true
    @event = Event.new
    @group_id = params[:id]

    @group = Group.find(@group_id)
    @group_admins = @group.admin_users
  end

  def submit
    @event = Event.new(event_params)
    @event.groups << Group.find_by(@group_id)

    if (@event.save)
      redirect_to '/events'
    else
      render 'new'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  private

    def event_params
      params.require(:event).permit(:end_datetime, :name, :location, :description, :start_datetime, :image)
    end
end
