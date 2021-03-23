# frozen_string_literal: true

RSpec.describe Grouping do
  describe ".start" do
    let(:argv) { ["file.csv", "email"] }

    before { allow(File).to receive(:file?).and_return(true) }

    subject { described_class.start(argv) }

    it "executes the program" do
      expect { subject }.to output(
        <<~OUTPUT
          file.csv
          email
        OUTPUT
      ).to_stdout
    end

    describe "when arguments are not valid" do
      let(:argv) { [] }

      it "exits" do
        expect { subject }.to raise_error(SystemExit)
      end
    end
  end
end
