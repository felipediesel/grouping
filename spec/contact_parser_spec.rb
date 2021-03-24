# frozen_string_literal: true

RSpec.describe ContactParser do
  let(:filename) { File.join(__dir__, "../spec/fixtures/input1.csv") }

  describe "#new" do
    subject { described_class.new(filename) }

    it "stores filename as an attribute" do
      expect(subject.filename).to eq(filename)
    end
  end

  describe ".data" do
    subject { described_class.new(filename).data }

    it "returns the data from the CSV file" do
      expect(subject.length).to be(8)
      expect(subject[0]).to eq(
        first_name: "John",
        last_name: "Smith",
        phone: "(555) 123-4567",
        email: "johns@home.com",
        zip: "94105"
      )
    end
  end

  describe ".header" do
    subject { described_class.new(filename).header }

    it "returns the header from the CSV file" do
      expect(subject).to eq(%w[FirstName LastName Phone Email Zip])
    end
  end
end
