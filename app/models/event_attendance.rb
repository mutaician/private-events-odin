class EventAttendance < ApplicationRecord
  # This is a join table between User and Event

  # This event_attendance record belongs to attendee
  belongs_to :attendee, class_name: 'User', foreign_key: :attendee_id
  # This event_attendance record belongs to attended_event
  belongs_to :attended_event, class_name: 'Event', foreign_key: :attended_event_id
end
