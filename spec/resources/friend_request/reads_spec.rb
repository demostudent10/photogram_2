require "rails_helper"

RSpec.describe FriendRequestResource, type: :resource do
  describe "serialization" do
    let!(:friend_request) { create(:friend_request) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(friend_request.id)
      expect(data.jsonapi_type).to eq("friend_requests")
    end
  end

  describe "filtering" do
    let!(:friend_request1) { create(:friend_request) }
    let!(:friend_request2) { create(:friend_request) }

    context "by id" do
      before do
        params[:filter] = { id: { eq: friend_request2.id } }
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([friend_request2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:friend_request1) { create(:friend_request) }
      let!(:friend_request2) { create(:friend_request) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      friend_request1.id,
                                      friend_request2.id,
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
                                      friend_request2.id,
                                      friend_request1.id,
                                    ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
