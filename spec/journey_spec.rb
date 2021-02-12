require 'journey'

describe Journey do
	let(:entry_station) { double :entry_station, name: :entry_station }
	let(:exit_station) { double :exit_station, name: :exit_station }
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
	
	describe '#save_entry' do
		it 'should record the entry station of a journey' do
			expect(subject.save_entry(:entry_station)).to_not be_nil
		end
	end
	

	describe '#save_exit' do
		it 'should record the exit station of a journey' do
			expect(subject.save_exit(:exit_station)).to_not be_nil
		end
	end

end

