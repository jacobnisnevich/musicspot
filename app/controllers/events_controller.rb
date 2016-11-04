class EventsController < ApplicationController
  def home
    @events = Event.all.to_a
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
