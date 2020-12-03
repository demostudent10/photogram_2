class Api::V1::FriendRequestsController < Api::V1::GraphitiController
  def index
    friend_requests = FriendRequestResource.all(params)
    respond_with(friend_requests)
  end

  def show
    friend_request = FriendRequestResource.find(params)
    respond_with(friend_request)
  end

  def create
    friend_request = FriendRequestResource.build(params)

    if friend_request.save
      render jsonapi: friend_request, status: :created
    else
      render jsonapi_errors: friend_request
    end
  end

  def update
    friend_request = FriendRequestResource.find(params)

    if friend_request.update_attributes
      render jsonapi: friend_request
    else
      render jsonapi_errors: friend_request
    end
  end

  def destroy
    friend_request = FriendRequestResource.find(params)

    if friend_request.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: friend_request
    end
  end
end
