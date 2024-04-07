class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  has_many :event_attendances, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_attendances, source: :attendee

  has_many :invitations, dependent: :destroy
  has_many :invitees, through: :invitations, source: :invitee

  validates :name, :date, :location, presence: true
end
