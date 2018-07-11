class EventsUsers < ActiveRecord::Migration[5.1]
	def change
		create_table :events_users, id: false do |t|
			t.belongs_to :event, index: true
			t.belongs_to :user, index: true
			t.integer :event_id
			t.integer :user_id
		end
	end
end
