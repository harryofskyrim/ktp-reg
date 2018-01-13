class Event < ApplicationRecord
	has_and_belongs_to_many :teams
	has_and_belongs_to_many :users
	
  def valid_date_range_required
    if (dateStart && dateEnd) && (dateStart > dateEnd)
      errors.add(:dateEnd, "не должна быть раньше даты начала")
    end
  end
  
  validates :eventTitle, presence: true, uniqueness: true
  validates :eventType, presence: true
  validates :dateStart, presence: true
  validates :dateEnd, presence: true
  validate  :valid_date_range_required
  validates :teamMinSize, presence: true, numericality: { only_integer: true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 15 }
  validates :eventPlace, presence: true
end
