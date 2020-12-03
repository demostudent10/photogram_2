class Api::V1::GraphitiController < ApplicationController
  skip_before_action :authenticate_user!
  before_action -> { doorkeeper_authorize! :public }

  include Graphiti::Rails::Responders

  def current_resource_owner
    doorkeeper_token.resource_owner
  end
end
