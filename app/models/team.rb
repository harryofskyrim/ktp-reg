class Team < ApplicationRecord
#	has_many :memberships, :foreign_key => :team_id
#	has_many :users, :through => :memberships
	has_and_belongs_to_many :users
end