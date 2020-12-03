class VotesController < ApplicationController
  before_action :current_user_must_be_vote_user, only: %i[edit update destroy]

  before_action :set_vote, only: %i[show edit update destroy]

  def index
    @q = current_user.likes.ransack(params[:q])
    @votes = @q.result(distinct: true).includes(:user, :photo).page(params[:page]).per(10)
  end

  def show; end

  def new
    @vote = Vote.new
  end

  def edit; end

  def create
    @vote = Vote.new(vote_params)

    if @vote.save
      message = "Vote was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @vote, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @vote.update(vote_params)
      redirect_to @vote, notice: "Vote was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @vote.destroy
    message = "Vote was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to votes_url, notice: message
    end
  end

  private

  def current_user_must_be_vote_user
    set_vote
    unless current_user == @vote.user
      redirect_back fallback_location: root_path, alert: "You are not authorized for that."
    end
  end

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:user_id, :photo_id)
  end
end
