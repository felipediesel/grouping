# frozen_string_literal: true

RSpec.describe FilenameGenerator do
  let(:original_filename) { "input.csv" }

  describe "#call" do
    subject { described_class.call(original_filename) }

    context "when file does not exists" do
      before { allow(File).to receive(:exist?).and_return(false) }

      it { is_expected.to eq("input.grouped.csv") }
    end

    context "when file does not have an extenstion" do
      let(:original_filename) { "input" }

      before { allow(File).to receive(:exist?).and_return(false) }

      it { is_expected.to eq("input.grouped.csv") }
    end

    context "when one file exists" do
      before { allow(File).to receive(:exist?).and_return(true, false) }

      it { is_expected.to eq("input.grouped.1.csv") }
    end

    context "when multiple files exist" do
      before { allow(File).to receive(:exist?).and_return(true, true, true, false) }

      it { is_expected.to eq("input.grouped.3.csv") }
    end
  end
end
