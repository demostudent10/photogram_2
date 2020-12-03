class PhotoResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :caption, :string
  attribute :image, :string
  attribute :location, :string
  attribute :owner_id, :integer
  attribute :status, :integer_enum, allow: Photo.statuses.keys

  # Direct associations

  has_many   :likes,
             resource: VoteResource

  belongs_to :owner,
             resource: UserResource

  # Indirect associations

end
