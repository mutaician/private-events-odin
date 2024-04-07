class EventAttendancesController < ApplicationController
  def create
    # @event = Event.find(params[:event_id])
    # @event_attendance = @event.event_attendances.build(attendee_id: current_user.id)
    @event_attendance = current_user.event_attendances.build(attended_event_id: params[:event_id])
    if @event_attendance.save
      redirect_to event_path(params[:event_id]), notice: 'You have successfully registered for this event.'
    else
      redirect_to event_path(params[:event_id]), alert: @event_attendance.errors.full_messages.to_sentence
    end
  end

  def destroy
    @event_attendance = EventAttendance.find_by(attended_event_id: params[:event_id], attendee_id: current_user.id)
    @event_attendance.destroy
    redirect_to event_path(@event_attendance.attended_event_id), notice: 'You have successfully unregistered for this event.'
  end
end
