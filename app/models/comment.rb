class Comment < ApplicationRecord
  # Direct associations

  belongs_to :photo,
             :counter_cache => true

  belongs_to :commenter,
             :class_name => "User"

  # Indirect associations

  # Validations

  validates :body, :presence => true

  # Scopes

  def to_s
    body
  end

end
