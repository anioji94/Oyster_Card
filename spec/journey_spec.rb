require 'journey'

describe Journey do
	penalty = Journey::PENALTY_FARE
	min = Journey::MINIMUM_FARE

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
			expect(subject.save_entry(entry_station)).to_not be_nil
		end
	end


	describe '#save_exit' do
		it 'should record the exit station of a journey' do
			expect(subject.save_exit(exit_station)).to_not be_nil
		end
	end

	describe '#incomplete?' do
		it 'should return true if entry saved but not exit' do
			subject.save_entry(entry_station)
			expect(subject.incomplete?).to be true
		end
		it 'should return true if exit saved but not entry' do
			subject.save_exit(exit_station)
			expect(subject.incomplete?).to be true
		end
		it 'should return false if both entry and exit are empty' do
			expect(subject.incomplete?).to be false
		end
		it 'should return false if neither entry and exit are empty' do
			subject.save_entry(entry_station)
			subject.save_exit(exit_station)
			expect(subject.incomplete?).to be false
		end
	end

	describe '#fare' do
		it 'returns penalty if journey incomplete' do
			subject.save_entry(entry_station)
			expect(subject.fare).to eq penalty
		end
		it 'returns min_fare if journey complete' do
			subject.save_entry(entry_station)
			subject.save_exit(exit_station)
			expect(subject.fare).to eq min
		end
	end

end
