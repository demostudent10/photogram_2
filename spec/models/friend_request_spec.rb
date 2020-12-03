require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  
    describe "Direct Associations" do

    it { should belong_to(:accepted_recipient) }

    it { should belong_to(:recipient) }

    it { should belong_to(:sender) }

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do

    it { should validate_uniqueness_of(:recipient_id).scoped_to(:sender_id).with_message('already requested') }

    it { should validate_presence_of(:recipient_id) }

    it { should validate_presence_of(:sender_id) }

    it { should validate_presence_of(:status) }

    it { should validate_inclusion_of(:status).in_array([ "pending", "accepted", "declined" ]) }

    end
end
