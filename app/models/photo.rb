class Photo < ApplicationRecord
  enum status: {"old"=>0, "recent"=>1} 

  # Direct associations

  belongs_to :owner,
             :class_name => "User",
             :counter_cache => true

  # Indirect associations

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

  # Scopes

  def to_s
    caption
  end

end
