require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  
    describe "Direct Associations" do

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do

    it { should validate_presence_of(:sender_id) }

    it { should validate_presence_of(:status) }

    it { should validate_inclusion_of(:status).in_array([ "pending", "accepted", "declined" ]) }

    end
end
