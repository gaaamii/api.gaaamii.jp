require "rails_helper"

RSpec.describe PostsController, type: :request do
  include Requests::LoginHelper

  describe "(GET) /admin/posts" do
    subject do
      get "/admin/posts"
    end
    context 'when logged in' do
      let(:user) { FactoryBot.create(:user) }
      before { login(user.email, 'test_password') }

      it "returns an index of posts" do
        subject
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to be_kind_of(Array)
      end
    end

    context 'when not logged in' do
      it "returns 401 response" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
