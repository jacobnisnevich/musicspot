class DistanceSort < SortStrategy
	def search(groups, destinations)
		return groups.sort_by { |group| destinations.distances[group.location][:value]}
	end
end
