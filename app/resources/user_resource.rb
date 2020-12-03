class UserResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :email, :string
  attribute :password, :string
  attribute :username, :string
  attribute :avatar, :string
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :bio, :string

  # Direct associations

  has_many   :likes,
             resource: VoteResource

  has_many   :photos,
             foreign_key: :owner_id

  # Indirect associations

end
