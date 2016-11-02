class GroupEvent < ApplicationRecord
	belongs_to :groups
	belongs_to :event
end
