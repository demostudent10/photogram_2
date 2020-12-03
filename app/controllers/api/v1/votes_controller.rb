class Api::V1::VotesController < Api::V1::GraphitiController
  def index
    votes = VoteResource.all(params)
    respond_with(votes)
  end

  def show
    vote = VoteResource.find(params)
    respond_with(vote)
  end

  def create
    vote = VoteResource.build(params)

    if vote.save
      render jsonapi: vote, status: :created
    else
      render jsonapi_errors: vote
    end
  end

  def update
    vote = VoteResource.find(params)

    if vote.update_attributes
      render jsonapi: vote
    else
      render jsonapi_errors: vote
    end
  end

  def destroy
    vote = VoteResource.find(params)

    if vote.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: vote
    end
  end
end
