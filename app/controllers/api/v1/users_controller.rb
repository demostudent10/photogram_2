class Api::V1::UsersController < Api::V1::GraphitiController
  def index
    users = UserResource.all(params)
    respond_with(users)
  end

  def show
    base_scope = params[:id].blank? ? User.where(id: current_resource_owner) : User.all
    user = UserResource.find(params, base_scope)
    respond_with(user)
  end


  def create
    user = UserResource.build(params)

    if user.save
      render jsonapi: user, status: 201
    else
      render jsonapi_errors: user
    end
  end

  def update
    user = UserResource.find(params)

    if user.update_attributes
      render jsonapi: user
    else
      render jsonapi_errors: user
    end
  end

  def destroy
    user = UserResource.find(params)

    if user.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: user
    end
  end
end
