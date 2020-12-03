require "rails_helper"

RSpec.describe VoteResource, type: :resource do
  describe "serialization" do
    let!(:vote) { create(:vote) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(vote.id)
      expect(data.jsonapi_type).to eq("votes")
    end
  end

  describe "filtering" do
    let!(:vote1) { create(:vote) }
    let!(:vote2) { create(:vote) }

    context "by id" do
      before do
        params[:filter] = { id: { eq: vote2.id } }
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([vote2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:vote1) { create(:vote) }
      let!(:vote2) { create(:vote) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      vote1.id,
                                      vote2.id,
                                    ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      vote2.id,
                                      vote1.id,
                                    ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
