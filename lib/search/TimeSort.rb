class TimeSort < SortStrategy
	def search(groups, destinations)
		return groups.sort_by { |group| destinations.durations[group.location][:value]}
	end
end
