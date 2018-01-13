class Team < ApplicationRecord
	has_and_belongs_to_many :users
	has_and_belongs_to_many :events
	validates :teamTitle, presence: true, length: { maximum: 50 }
end
