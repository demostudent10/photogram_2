class FriendRequest < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  # Scopes

  def to_s
    sender.to_s
  end

end
