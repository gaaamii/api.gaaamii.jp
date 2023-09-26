require "rails_helper"

RSpec.describe LinksController, type: :request do
  include Requests::LoginHelper

  describe "(PUT) /links" do
    subject do
      put "/links", params: links_params
    end

    context 'authenticated' do
      let(:user) { FactoryBot.create(:user) }
      before { login(user.email, 'test_password') }

      context 'when add a new link' do
        let(:links_params) do
          {
            links: [
              {
                name: 'Example',
                url: 'https://www.example.com',
              }
            ]
          }
        end

        it "Add a link and returns 204" do
          expect { subject }.to change(Link, :count).by(1)
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'when add two new links' do
        let(:links_params) do
          {
            links: [
              {
                name: 'Example1',
                url: 'https://www.example.com/1',
              },
              {
                name: 'Example2',
                url: 'https://www.example.com/2',
              }
            ]
          }
        end

        it "Add a link and returns 204" do
          expect { subject }.to change(Link, :count).by(2)
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'when add a new link and a existing link' do
        let!(:existing_link) do
          FactoryBot.create(:link, name: 'Existing Example', url: 'https://www.example.com/existing')
        end

        let(:links_params) do
          {
            links: [
              # new
              {
                name: 'New Example',
                url: 'https://www.example.com/new',
              },

              # existing
              {
                name: 'Updated Name',
                url: 'https://www.example.com/existing',
              }
            ]
          }
        end

        it "Add a link and update a link, then returns 204" do
          expect { subject }.to change(Link, :count).by(1)
          expect(existing_link.reload).to have_attributes(name: 'Updated Name')
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'when existing link is not included' do
        let!(:existing_link) do
          FactoryBot.create(:link, name: 'Existing Example', url: 'https://www.example.com/existing')
        end
        let(:links_params) do
          { links: [] }
        end

        it 'deletes existing link' do
          expect { subject }.to change(Link, :count).by(-1)
          expect { existing_link.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'not authenticated' do
      let(:links_params) { { links: [] } }
      it "returns 401 http status" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "(GET) /links" do
    subject do
      get "/links"
    end

    context 'authenticated' do
      let(:user) { FactoryBot.create(:user) }
      let!(:links) {
        FactoryBot.create_list(:link, 2)
      }
      before { login(user.email, 'test_password') }

      it "returns 200 status and links response" do
        subject
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([
          {
            'id' => links.first.id,
            'name' => links.first.name,
            'url' => links.first.url
          },
          {
            'id' => links.second.id,
            'name' => links.second.name,
            'url' => links.second.url
          },
        ])
      end
    end

    context 'not authenticated' do
      it "returns 401 http status" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
