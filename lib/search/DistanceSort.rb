require 'search/SortStrategy'

class DistanceSort < SortStrategy
	def sort(groups, destinations)
		return groups.sort_by { |group| destinations.distances[group.location][:value]}
	end
end
