require 'rails_helper'

RSpec.describe "votes#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/votes", params: params
  end

  describe 'basic fetch' do
    let!(:vote1) { create(:vote) }
    let!(:vote2) { create(:vote) }

    it 'works' do
      expect(VoteResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['votes'])
      expect(d.map(&:id)).to match_array([vote1.id, vote2.id])
    end
  end
end
