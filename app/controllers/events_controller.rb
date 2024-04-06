class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :location, :date)
  end

end
