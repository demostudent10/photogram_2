class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:show, :edit, :update, :destroy]

  # GET /friend_requests
  def index
    @friend_requests = FriendRequest.all
  end

  # GET /friend_requests/1
  def show
  end

  # GET /friend_requests/new
  def new
    @friend_request = FriendRequest.new
  end

  # GET /friend_requests/1/edit
  def edit
  end

  # POST /friend_requests
  def create
    @friend_request = FriendRequest.new(friend_request_params)

    if @friend_request.save
      redirect_to @friend_request, notice: 'Friend request was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /friend_requests/1
  def update
    if @friend_request.update(friend_request_params)
      redirect_to @friend_request, notice: 'Friend request was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /friend_requests/1
  def destroy
    @friend_request.destroy
    redirect_to friend_requests_url, notice: 'Friend request was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend_request
      @friend_request = FriendRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def friend_request_params
      params.require(:friend_request).permit(:sender_id, :recipient_id, :status)
    end
end
