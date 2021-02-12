class Journey
	attr_reader :exit_station, :entry_station

	def initialize
		@entry_station
		@exit_station
	end

	def save_entry(station)
		@entry_station = station
	end

	def save_exit(station)
		@exit_station = station
	end
end