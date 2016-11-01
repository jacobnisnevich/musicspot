require 'search/SortStrategy'

class TimeSort < SortStrategy
	def self.sort(groups, destinations)
		return groups.sort_by { |group| destinations.durations[group.location][:value]}
	end
end
