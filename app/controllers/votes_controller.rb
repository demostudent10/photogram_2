class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  def create
    @vote = Vote.new(vote_params)

    if @vote.save
      redirect_to @vote, notice: 'Vote was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /votes/1
  def update
    if @vote.update(vote_params)
      redirect_to @vote, notice: 'Vote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /votes/1
  def destroy
    @vote.destroy
    message = "Vote was successfully deleted."
    if Rails.application.routes.recognize_path(request.referrer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referrer, notice: message
    else
      redirect_to votes_url, notice: message
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_params
      params.require(:vote).permit(:user_id, :photo_id)
    end
end
