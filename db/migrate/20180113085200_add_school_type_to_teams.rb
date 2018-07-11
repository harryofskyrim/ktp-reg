class AddSchoolTypeToTeams < ActiveRecord::Migration[5.1]
	def change
		add_column :teams, :schoolType, :string
  end
end
