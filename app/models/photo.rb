class Photo < ApplicationRecord
  enum status: {"old"=>0, "recent"=>1} 

  # Direct associations

  has_many   :comments,
             :dependent => :destroy

  has_many   :likes,
             :class_name => "Vote",
             :dependent => :destroy

  belongs_to :owner,
             :class_name => "User",
             :counter_cache => true

  # Indirect associations

  has_many   :fans,
             :through => :likes,
             :source => :user

  has_many   :commenters,
             :through => :comments,
             :source => :commenter

  has_many   :followers,
             :through => :owner,
             :source => :followers

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

  # Scopes

  def to_s
    caption
  end

end
