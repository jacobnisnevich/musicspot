class EventsController < ApplicationController
  def home
    @events = Event.all.to_a
  end

  def new
    @event = Event.new
    @group_id = params[:id]
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
