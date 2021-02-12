require 'oystercard.rb'
require 'journey.rb'

describe OysterCard do
	let(:entry_station) { double :entry_station, name: :entry_station }
	let(:exit_station) { double :exit_station, name: :exit_station }
  min_fare = OysterCard::MIN_FARE
	penalty = Journey::PENALTY_FARE

  #it { is_expected.to respond_to :check_balance }
  describe '#balance' do
    it 'Checks that balance is 0' do
      expect(subject.balance).to eq 0
    end

    it "Sends an error if user tries to top up beyond £90 and rejects payment" do
      expect{subject.top_up(100)}.to raise_error "Limit of £#{:limit} exceeded: payment rejected."
    end
  end

  describe '#top_up' do
    it 'Enables a top up with an amount chosen by the user' do
      expect{subject.top_up(20)}.to change {subject.balance}.by(20)
    end
    it 'requires at least £1 to successfully tap in' do
      subject.top_up(0.9)
      expect{subject.touch_in(:entry_station)}.to raise_error "Insufficient funds"
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to :touch_in }
		it 'deducts max fare when touching in having never touched out' do
			subject.top_up(5)
			subject.touch_in(:entry_station)
			expect { subject.touch_in(:entry_station)}.to change{subject.balance}.by(-penalty)
		end
		it 'saves incomplete journey when touching in having never touched out' do
			subject.top_up(5)
			subject.touch_in(:entry_station)
			expect { subject.touch_in(:entry_station)}.to change{subject.card_history.length}.by 1
		end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to :touch_out }
    it 'deducts max fare when tapping out with no entry station' do
      expect { subject.touch_out(:exit_station)}.to change{subject.balance}.by(-penalty)
    end
		it 'deducts min fare when tapping out completes journey' do
			subject.top_up(5)
			subject.touch_in(:entry_station)
			expect { subject.touch_out(:exit_station)}.to change{subject.balance}.by(-min_fare)
		end
		it 'saves incomplete journey when touching out having never touched in' do
			expect { subject.touch_out(:exit_station) }.to change{subject.card_history.length}.by 1
		end
  end

  describe '#history' do
    it 'should register journey history' do
      subject.top_up(10)
      subject.touch_in(:entry_station)
      expect { subject.touch_out(:exit_station) }.to change { subject.card_history.length }.by 1
    end

  end
  end
