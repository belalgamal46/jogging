class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    if resource.persisted?
      render json: {
        status: 200,
        message: 'Signed up successfully',
        data: resource
      }
    else
      render json: {
        message: 'User could not be created',
        errors: resource.errors.full_messages,
        status: 422
      }
    end
  end
end
