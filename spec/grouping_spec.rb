# frozen_string_literal: true

RSpec.describe Grouping do
  describe ".start" do
    let(:filename) { File.join(__dir__, "../spec/fixtures/input1.csv") }
    let(:argv) { [filename, "email"] }

    before { allow(File).to receive(:file?).and_return(true) }

    subject { described_class.start(argv) }

    it "executes the program" do
      expect(subject.length).to eq(8)
    end

    describe "when arguments are not valid" do
      let(:argv) { [] }

      it "exits" do
        expect { subject }.to raise_error(SystemExit)
      end
    end
  end
end
