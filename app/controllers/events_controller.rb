class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    # @events = Event.all
    @past_events = Event.where('date < ?', Date.today)
    @upcoming_events = Event.where('date >= ?', Date.today)
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      if @event.private
        invitee_ids = params[:event][:invitee_ids].reject(&:blank?)
        invitee_ids.each do |invitee_id|
          Invitation.create(inviter_id: current_user.id, invitee_id: invitee_id, event_id: @event.id) if invitee_id.present?
        end
      end
      redirect_to my_created_events_path, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def my_events
    @my_attended_events = current_user.attended_events
  end

  def my_created_events
    @created_events = current_user.created_events
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully deleted.'
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      @event.invitations.destroy_all
      if @event.private
        invitee_ids = params[:event][:invitee_ids].reject(&:blank?)
        invitee_ids.each do |invitee_id|
          Invitation.create(inviter_id: current_user.id, invitee_id: invitee_id, event_id: @event.id) if invitee_id.present?
        end
      end
      redirect_to event_path(@event), notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :location, :date, :private)
  end

end
