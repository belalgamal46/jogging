class ApiController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    render json: { message: exception, status: 'failed' }, status: :unauthorized
  end
end
