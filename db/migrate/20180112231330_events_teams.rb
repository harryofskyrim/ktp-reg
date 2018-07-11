class EventsTeams < ActiveRecord::Migration[5.1]
	def change
		create_table :events_teams, id: false do |t|
			t.belongs_to :event, index: true
			t.belongs_to :team, index: true
			t.integer :event_id
			t.integer :team_id
		end
	end
end
