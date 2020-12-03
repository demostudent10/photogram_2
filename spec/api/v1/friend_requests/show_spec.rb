require "rails_helper"

RSpec.describe "friend_requests#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/friend_requests/#{friend_request.id}", params: params
  end

  describe "basic fetch" do
    let!(:friend_request) { create(:friend_request) }

    it "works" do
      expect(FriendRequestResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("friend_requests")
      expect(d.id).to eq(friend_request.id)
    end
  end
end
