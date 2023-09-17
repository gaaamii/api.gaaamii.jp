require 'rails_helper'

RSpec.describe Link, type: :model do
  describe "url validation" do
    subject { FactoryBot.build(:link, url: url) }

    context "valid url" do
      let(:url) { "https://www.example.com" }

      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "invalid url" do
      let(:url) { "www.example.com" }

      it "is invalid" do
        expect(subject).to be_invalid
      end
    end
  end
end
