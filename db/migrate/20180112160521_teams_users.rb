class TeamsUsers < ActiveRecord::Migration[5.1]
  def change
		create_table :teams_users, id: false do |t|
		  t.belongs_to :user, index: true
			t.belongs_to :team, index: true
			t.integer :user_id
			t.integer :team_id
	  end
  end
end
