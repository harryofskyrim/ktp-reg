class AddSchoolTypeToEvents < ActiveRecord::Migration[5.1]
	def change
		add_column :events, :schoolType, :string
  end
end
