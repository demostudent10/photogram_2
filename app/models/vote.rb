class Vote < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :user_id, :presence => true

  # Scopes

  def to_s
    user.to_s
  end

end
