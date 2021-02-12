require 'journey'

describe Journey do
	# in_journey
	# touch_in
	# touch_out
	describe '#initialize' do
		it 'should allow a journey to have an entry station' do
			expect(subject.entry_station).to be_nil
		end
		it 'should allow a journey to have an exit station' do
			expect(subject.exit_station).to be_nil
		end
	end
end

