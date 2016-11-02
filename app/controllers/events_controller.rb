class EventsController < ApplicationController
  def home
    @events = Event.all.to_a
  end

  def new
    @event = Event.new
  end

  def submit
    @event = Event.new(params.require(:event).permit(:end_datetime, :name, :location, :description, :start_datetime))
    @event.save

    redirect_to '/events'
  end

  def show
    @full_width = true
    @event = Event.find_by(id: params[:id])
  end
end
