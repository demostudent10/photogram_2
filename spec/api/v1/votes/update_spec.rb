require 'rails_helper'

RSpec.describe "votes#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/votes/#{vote.id}", payload
  end

  describe 'basic update' do
    let!(:vote) { create(:vote) }

    let(:payload) do
      {
        data: {
          id: vote.id.to_s,
          type: 'votes',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(VoteResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { vote.reload.attributes }
    end
  end
end
