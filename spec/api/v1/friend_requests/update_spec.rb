require 'rails_helper'

RSpec.describe "friend_requests#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/friend_requests/#{friend_request.id}", payload
  end

  describe 'basic update' do
    let!(:friend_request) { create(:friend_request) }

    let(:payload) do
      {
        data: {
          id: friend_request.id.to_s,
          type: 'friend_requests',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(FriendRequestResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { friend_request.reload.attributes }
    end
  end
end
