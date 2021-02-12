class Journey
	PENALTY_FARE = 6
	MINIMUM_FARE = 1

	attr_reader :exit_station, :entry_station

	def initialize
		@entry_station = nil
		@exit_station = nil
	end

	def save_entry(station)
		@entry_station = station.name
	end

	def save_exit(station)
		@exit_station = station.name
	end

	def incomplete?
		(!@entry_station && !!@exit_station) || (!!@entry_station && !@exit_station) ? true : false
	end

	def fare
		incomplete? ? PENALTY_FARE : MINIMUM_FARE
	end

end
