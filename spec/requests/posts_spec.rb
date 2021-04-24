require "rails_helper"

RSpec.describe PostsController, type: :request do
  describe "#index" do
    it "returns an index of posts" do
      get "/posts"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_kind_of(Array)
    end
  end
end
