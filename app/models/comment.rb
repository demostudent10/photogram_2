class Comment < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :body, :presence => true

  # Scopes

  def to_s
    body
  end

end
