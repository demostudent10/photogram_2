json.extract! photo, :id, :caption, :image, :location, :owner_id, :status, :created_at, :updated_at
json.url photo_url(photo, format: :json)
