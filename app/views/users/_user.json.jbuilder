json.extract! user, :id, :username, :avatar, :first_name, :last_name, :bio, :created_at, :updated_at
json.url user_url(user, format: :json)
