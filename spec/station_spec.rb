require 'station'

describe Station do
	describe '#initialize' do
			let(:station) {Station.new('Oval', 2)}
		it 'should initialize a station name' do
			expect(station.name).to eq('Oval')
		end
		it 'should initialize a station zone' do
			expect(station.zone).to eq(2)
		end
	end
end

# station needs to be