class FriendRequest < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :status, :inclusion => { :in => [ "pending", "accepted", "declined" ]  }

  # Scopes

  def to_s
    sender.to_s
  end

end
