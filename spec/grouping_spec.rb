# frozen_string_literal: true

RSpec.describe Grouping do
  describe ".start" do
    let(:filename) { File.join(__dir__, "../spec/fixtures/input1.csv") }
    let(:argv) { [filename, "email"] }

    before do
      allow(File).to receive(:file?).and_return(true)
      allow(File).to receive(:write)
    end

    subject { described_class.start(argv) }

    it "executes the program" do
      expect { subject }.to output(%r{spec/fixtures/input1.grouped.csv}).to_stdout
    end

    describe "when arguments are not valid" do
      let(:argv) { [] }

      it "exits" do
        expect { subject }.to raise_error(SystemExit)
      end
    end
  end
end
