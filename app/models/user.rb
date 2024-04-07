class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: :creator_id

  has_many :event_attendances, foreign_key: :attendee_id
  has_many :attended_events, through: :event_attendances

  has_many :invitations_sent, foreign_key: :inviter_id, class_name: 'Invitation'
  has_many :invitations_received, foreign_key: :invitee_id, class_name: 'Invitation'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
