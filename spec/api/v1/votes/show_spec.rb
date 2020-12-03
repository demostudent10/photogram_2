require "rails_helper"

RSpec.describe "votes#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/votes/#{vote.id}", params: params
  end

  describe "basic fetch" do
    let!(:vote) { create(:vote) }

    it "works" do
      expect(VoteResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("votes")
      expect(d.id).to eq(vote.id)
    end
  end
end
