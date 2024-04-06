class CreateEventAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :event_attendances do |t|
      t.references :attendee, null: false, foreign_key: true
      t.references :attended_event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
