require "rails_helper"

RSpec.describe "friend_requests#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/friend_requests", payload
  end

  describe "basic create" do
    let(:params) do
      {
        # ... your attrs here
      }
    end
    let(:payload) do
      {
        data: {
          type: "friend_requests",
          attributes: params,
        },
      }
    end

    it "works" do
      expect(FriendRequestResource).to receive(:build).and_call_original
      expect do
        make_request
        expect(response.status).to eq(201), response.body
      end.to change { FriendRequest.count }.by(1)
    end
  end
end
