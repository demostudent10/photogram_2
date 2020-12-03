require "rails_helper"

RSpec.describe "friend_requests#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/friend_requests/#{friend_request.id}"
  end

  describe "basic destroy" do
    let!(:friend_request) { create(:friend_request) }

    it "updates the resource" do
      expect(FriendRequestResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { FriendRequest.count }.by(-1)
      expect { friend_request.reload }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
