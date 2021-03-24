# frozen_string_literal: true

RSpec.describe Matcher do
  let(:type) { :email }
  let(:data) do
    [
      { first_name: "John", email: "john@example.com", phone: "1112223333" },
      { first_name: "John Lennon", email: "john@example.com", phone: "1112223333" },
      { first_name: "Paul", email: "paul@example.com", phone: "1112224444" },
      { first_name: "Paul McCartney", email: "", phone: "1112224444" },
      { first_name: "George", email: nil },
      { first_name: "Ringo", email: nil }
    ]
  end

  describe "#call" do
    subject { described_class.call(data, type) }

    context "when type is email" do
      context "when the email has the same value on different rows" do
        it "sets the same uuid" do
          expect(subject[0][:uuid]).not_to be_nil
          expect(subject[0][:uuid]).to eq(subject[1][:uuid])
          expect(subject[0][:uuid]).not_to eq(subject[2][:uuid])
        end
      end
    end

    context "when type is phone" do
      let(:type) { :phone }

      context "when the phone has the same value on different rows" do
        it "sets the same uuid" do
          expect(subject[2][:uuid]).not_to be_nil
          expect(subject[2][:uuid]).to eq(subject[3][:uuid])
          expect(subject[2][:uuid]).not_to eq(subject[0][:uuid])
        end
      end
    end

    context "when type is both" do
      let(:type) { :both }

      context "when the phone and email have the same valued on different rows" do
        it "sets the same uuid" do
          expect(subject[0][:uuid]).not_to be_nil
          expect(subject[0][:uuid]).to eq(subject[1][:uuid])
          expect(subject[0][:uuid]).not_to eq(subject[2][:uuid])
        end
      end
    end

    context "when the matching type column is nil" do
      it "adds a new uuid" do
        expect(subject[4][:uuid]).not_to be_nil
        expect(subject[4][:uuid]).not_to eq(subject[5][:uuid])
      end
    end

    context "when the matching type column is empty" do
      it "adds a new uuid" do
        expect(subject[3][:uuid]).not_to be_nil
        expect(subject[3][:uuid]).not_to eq(subject[4][:uuid])
      end
    end
  end
end
