# frozen_string_literal: true

RSpec.describe InputValidator do
  describe ".call!" do
    let(:filename) { "file.csv" }
    let(:matching_type) { "email" }
    let(:valid_file) { true }

    before { allow(File).to receive(:file?).and_return(valid_file) }

    subject { described_class.call!(filename, matching_type) }

    it "does not raise an error" do
      expect { subject }.not_to raise_error
    end

    describe "when params are nil" do
      let(:filename) { nil }
      let(:matching_type) { nil }

      it "prints help text" do
        expect { subject }.to raise_error(SystemExit).and output(/usage: grouping/).to_stdout
      end
    end

    describe "when an invalid file is provided" do
      let(:valid_file) { false }

      it "prints error and help text" do
        expect { subject }.to raise_error(SystemExit).and output(/is not a valid file(.*)usage: grouping/m).to_stdout
      end
    end

    describe "when an invalid match type is provided" do
      let(:matching_type) { "test" }

      it "prints error and help text" do
        expect do
          subject
        end.to raise_error(SystemExit).and output(/is not a valid matching type(.*)usage: grouping/m).to_stdout
      end
    end
  end
end
