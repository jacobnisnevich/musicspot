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

  def add_user
    if current_user
      @event = Event.find_by(id: params[:event_id])
      @event.users << current_user unless @event.users.include?(current_user)
      if (@event.save)
        redirect_to action: 'show', id: @event.id
      end
    end
  end

  def remove_user
    if current_user
      @event = Event.find_by(id: params[:event_id])
      @event.users.delete(current_user)
      if (@event.save)
        redirect_to action: 'show', id: @event.id
      end
    end
  end

  private

    def event_params
      params.require(:event).permit(:end_datetime, :name, :location, :description, :start_datetime, :image)
    end
end
