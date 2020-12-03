require 'rails_helper'

RSpec.describe VoteResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'votes',
          attributes: { }
        }
      }
    end

    let(:instance) do
      VoteResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Vote.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:vote) { create(:vote) }

    let(:payload) do
      {
        data: {
          id: vote.id.to_s,
          type: 'votes',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      VoteResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { vote.reload.updated_at }
      # .and change { vote.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:vote) { create(:vote) }

    let(:instance) do
      VoteResource.find(id: vote.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Vote.count }.by(-1)
    end
  end
end
