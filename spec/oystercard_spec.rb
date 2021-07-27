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
end