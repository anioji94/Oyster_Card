require_relative 'station.rb'
require_relative 'journey.rb'

class OysterCard
  attr_reader :balance, :limit, :card_history, :journey

  DEFAULT_LIMIT = 90
  MIN_TRAVEL_BALANCE = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
    @limit = DEFAULT_LIMIT
		@journey = Journey.new
		@card_history = []
  end

  def top_up(amount)
      raise "Limit of £#{:limit} exceeded: payment rejected." if @balance + amount >= @limit
      if @balance + amount < @limit then @balance += amount
      end
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MIN_TRAVEL_BALANCE
    complete_journey if @journey.incomplete?
    @journey.save_entry(station)
  end

  def touch_out(station)
    @journey.save_exit(station)
    complete_journey
  end

	def history
		@card_history
	end

private

def deduct(amount)
    @balance -= amount
end

def complete_journey
  deduct(@journey.fare)
  @card_history << @journey
  @journey = Journey.new
end

end
