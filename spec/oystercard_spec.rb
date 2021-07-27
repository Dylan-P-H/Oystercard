require 'oystercard'

describe Oystercard do
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
  it "If user has touched in, in_journey? method should be true" do
    subject.top_up(10)
    subject.touch_in
    expect( subject.in_journey? ).to eq(true)
  end
  it "Should change card_state if user invokes touch_out" do
    subject.touch_out
    expect( subject.in_journey? ).to eq(false)
  end
  it "Should fail if balance is less than minumum fair when touching in" do
    subject.top_up(0)
    expect{ subject.touch_in }.to raise_error "Insufficient funds for minimum fair"
  end
  it "Should deduct from my balance when I make a trip" do
    subject.top_up(10)
    expect { subject.touch_out }.to change{ subject.balance }.by(-1)
  end
end