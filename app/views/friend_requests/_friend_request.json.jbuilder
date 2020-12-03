json.extract! friend_request, :id, :sender_id, :recipient_id, :status, :created_at, :updated_at
json.url friend_request_url(friend_request, format: :json)
