class AddMoreParamsToEvents < ActiveRecord::Migration[5.1]
  def change
	  add_column :events, :fathersNameReq, :boolean
	  add_column :events, :bornReq, :boolean
	  add_column :events, :schoolReq, :boolean
	  add_column :events, :groupReq, :boolean
	  add_column :events, :phoneNumberReq, :boolean
	  add_column :events, :teeSizeReq, :boolean
  end
end
