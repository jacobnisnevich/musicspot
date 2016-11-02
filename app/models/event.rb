class Event < ApplicationRecord
	has_many :group_events
	has_many :groups, :through => :group_events

	validates :name, presence: true, length: { maximum: 50 }
	validates :location, presence: true, length: { maximum: 50 }
	validates :start_datetime, presence: true
end
