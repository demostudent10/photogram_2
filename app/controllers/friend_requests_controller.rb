class FriendRequestsController < ApplicationController
  before_action :current_user_must_be_friend_request_accepted_recipient, only: %i[edit update destroy]

  before_action :current_user_must_be_friend_request_sender, only: %i[edit update destroy]

  before_action :set_friend_request, only: %i[show edit update destroy]

  def index
    @q = current_user.accepted_friend_requests.ransack(params[:q])
    @friend_requests = @q.result(distinct: true).includes(:sender, :recipient, :accepted_recipient).page(params[:page]).per(10)
  end

  def show; end

  def new
    @friend_request = FriendRequest.new
  end

  def edit; end

  def create
    @friend_request = FriendRequest.new(friend_request_params)

    if @friend_request.save
      message = "FriendRequest was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @friend_request, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @friend_request.update(friend_request_params)
      redirect_to @friend_request, notice: "Friend request was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @friend_request.destroy
    message = "FriendRequest was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to friend_requests_url, notice: message
    end
  end

  private

  def current_user_must_be_friend_request_accepted_recipient
    set_friend_request
    unless current_user == @friend_request.accepted_recipient
      redirect_back fallback_location: root_path, alert: "You are not authorized for that."
    end
  end

  def current_user_must_be_friend_request_sender
    set_friend_request
    unless current_user == @friend_request.sender
      redirect_back fallback_location: root_path, alert: "You are not authorized for that."
    end
  end

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :recipient_id, :status)
  end
end
