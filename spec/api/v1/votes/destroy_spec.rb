require 'rails_helper'

RSpec.describe "votes#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/votes/#{vote.id}"
  end

  describe 'basic destroy' do
    let!(:vote) { create(:vote) }

    it 'updates the resource' do
      expect(VoteResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Vote.count }.by(-1)
      expect { vote.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
