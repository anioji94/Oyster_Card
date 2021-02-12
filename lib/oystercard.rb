require_relative 'station.rb'

class OysterCard
  attr_reader :balance, :limit, :entry_station, :exit_station, :card_history

  DEFAULT_LIMIT = 90
  MIN_TRAVEL_BALANCE = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
    @limit = DEFAULT_LIMIT
		@entry_station = nil
		@exit_station = nil
		@card_history = []
  end

  def top_up(amount)
      raise "Limit of £#{:limit} exceeded: payment rejected." if @balance + amount >= @limit
      if @balance + amount < @limit then @balance += amount
      end
  end

  def touch_in(station = Station.new)
    raise "Insufficient funds" if @balance < MIN_TRAVEL_BALANCE
    @entry_station = station.name
  end

  def touch_out(station = Station.new)
		deduct(MIN_FARE)
		@exit_station = station.name
    @card_history << {entry: entry_station, exit: exit_station}
		@entry_station = nil
  end

	def in_journey?
		return true if @entry_station != nil
	end

	def history
		@card_history
	end

private

def deduct(amount)
    @balance -= amount
end

end
