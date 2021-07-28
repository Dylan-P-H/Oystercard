require 'oystercard'

describe Oystercard do

  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  it "Has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it "Should top up balance" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(balance_limit)
      expect{ subject.top_up 1 }.to raise_error "Balance limit is #{balance_limit}"
    end
  end

  describe "#deduct" do
    it "Should deduct amount from balance" do
      test = Oystercard.new
      test.top_up(20)
      test.send(:deduct, 20)
      expect( test.balance ).to eq(0)
    end
  end

  it "Should fail if balance is less than minumum fair when touching in" do
    subject.top_up(0)
    expect{ subject.touch_in(:station) }.to raise_error "Insufficient funds for minimum fair"
  end

  it "Should deduct from my balance when I make a trip" do
    subject.top_up(10)
    expect { subject.touch_out(:station) }.to change{ subject.balance }.by(-1)
  end

  it "Should store journeys in a hash" do
    expect( subject.journey_log ).to be_empty
  end

  # it "Stores the users journey in the instance variable hash" do
  #   subject.top_up(10)
  #   subject.touch_in(entry_station)
  #   subject.touch_out(exit_station)
  #   expect( subject.journey_log.length ).to eq(1)
  # end

end