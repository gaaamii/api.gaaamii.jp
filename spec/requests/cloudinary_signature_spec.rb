require "rails_helper"

RSpec.describe PostsController, type: :request do
  include Requests::LoginHelper

  describe "(GET) /cloudinary_signature" do
    subject do
      get "/cloudinary_signature"
    end

    before do
      allow(Cloudinary::Utils).to receive(:api_sign_request).and_return('dummy signature')
    end

    context 'logged in as authenticated user' do
      let(:user) { FactoryBot.create(:user) }

      before { login(user.email, 'test_password')}

      it "returns an signature of cloudinary REST API" do
        subject
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include({
          'signature' => be_a(String),
          'api_key' => be_a(Integer)
        })
      end
    end

    context 'not logged in as authenticated user' do
      it "returns 400" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
