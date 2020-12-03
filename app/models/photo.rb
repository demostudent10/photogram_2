class Photo < ApplicationRecord
  enum status: {"old"=>0, "recent"=>1} 

  # Direct associations

  # Indirect associations

  # Validations

  validates :owner_id, :presence => true

  # Scopes

  def to_s
    caption
  end

end
