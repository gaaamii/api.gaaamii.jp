require "rails_helper"

RSpec.describe PostsController, type: :request do
  include Requests::LoginHelper

  describe "(GET) /posts" do
    it "returns an index of posts" do
      get "/posts"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_kind_of(Array)
    end
  end

  describe "(POST) /posts" do
    let(:post_params) do
      {
        post: {
          title: 'Title',
          body: 'body',
          published_at: Time.now.iso8601,
        }
      }
    end

    context 'when authenticated' do
      let(:user) { FactoryBot.create(:user) }
      before { login(user.email, 'test_password') }

      it "returns 201 http status" do
        post "/posts", params: post_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'when not authenticated' do
      it "returns 401 http status" do
        post "/posts", params: post_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
