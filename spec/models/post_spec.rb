require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "list scope" do
    subject { Post.list }

    let!(:posts) do
      FactoryBot.create_list(:post, 10)
    end

    it "loads required fields" do
      expect(subject).to all(have_attributes(title: be_a(String), published_at: ActiveSupport::TimeWithZone))
    end

    it "does not load :body field" do
      expect(subject.first).not_to respond_to(:body)
    end
  end
end
