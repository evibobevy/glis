class CreateEventsVolunteers < ActiveRecord::Migration
  def change
    create_table :events_volunteers do |t|
      t.integer :event_id
      t.integer :volunteer_id
    end
  end
end
