# frozen_string_literal: true

RSpec.describe CsvGenerator do
  let(:data) do
    [
      { uuid: "1", first_name: "John", email: "john@example.com", phone: "1112223333" },
      { uuid: "2", first_name: "Paul", email: nil, phone: "1112224444" }
    ]
  end
  let(:headers) { %w[UUID FirstName LastName Phone Email Zip] }
  let(:filename) { "tmp/file.csv" }

  describe "#call" do
    subject { described_class.call(data, headers, filename) }
    before { allow(File).to receive(:write) }

    it "saves the content to a file" do
      subject
      expect(File).to have_received(:write).with(filename, anything)
    end

    it "generates CSV content" do
      expected_result = <<~CSV
        UUID,FirstName,LastName,Phone,Email,Zip
        1,John,,1112223333,john@example.com,
        2,Paul,,1112224444,,
      CSV

      subject
      expect(File).to have_received(:write).with(anything, expected_result)
    end
  end
end
