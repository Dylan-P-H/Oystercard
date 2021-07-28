require 'journey'
require 'oystercard'

require 'journey'
describe Journey do
    let(:station) { double :station, zone: 1}
      it "knows if a journey is not complete" do
        expect(subject).not_to be_complete                            # I AM DRIVING THE PRODUCTION OF THE JOURNEY CLASS
                                                                      # WITH THE WALKTHROUGH TESTS SO I CAN FULLY UNDERSTAND
      end

      it 'has a penalty fare by default' do
        expect(subject.fare).to eq Journey::PENALTY_FARE
      end

      it "returns itself when exiting a journey" do
        expect(subject.finish(station)).to eq(subject)
      end

      context 'given an entry station' do
        subject {described_class.new(entry_station: station)}

        it 'has an entry station' do
          expect(subject.entry_station).to eq(station)
        end
      end
      it "returns a penalty fare if no exit station given" do
        expect(subject.fare).to eq Journey::PENALTY_FARE
      end

      context 'given an exit station' do
        let(:other_station) { double :other_station }

        before do
          expect(subject.finish).to eq(other_station)
        end
      end
      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it "knows if a journey is complete" do
        subject.finish(station)
        expect(subject).to be_complete
      end
end
