require 'rails_helper'

RSpec.describe "friend_requests#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/friend_requests", params: params
  end

  describe 'basic fetch' do
    let!(:friend_request1) { create(:friend_request) }
    let!(:friend_request2) { create(:friend_request) }

    it 'works' do
      expect(FriendRequestResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['friend_requests'])
      expect(d.map(&:id)).to match_array([friend_request1.id, friend_request2.id])
    end
  end
end
