class Event < ApplicationRecord
	has_many :group_events
	has_many :groups, :through => :group_events
end
