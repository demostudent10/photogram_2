class FriendRequest < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :recipient_id, :presence => true

  validates :sender_id, :presence => true

  validates :status, :presence => true

  validates :status, :inclusion => { :in => [ "pending", "accepted", "declined" ]  }

  # Scopes

  def to_s
    sender.to_s
  end

end
