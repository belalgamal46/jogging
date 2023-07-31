class Users::UsersController < ApiController
  load_and_authorize_resource
  before_action :set_user, only: %i[update destroy]

  def index
    render json: current_user, status: :ok
  end

  def update
    if @user.update(user_params)
      render json: { data: @user, status: 'success', message: 'User have been updated successfully' }, status: :ok
    else
      render json: { message: @user.errors.full_messages, status: 'failed' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { data: @user, message: 'User is deleted successfully', status: 'success' }, status: :ok
    else
      render json: { message: 'Something went wrong', status: 'failed' }, status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :name, :password)
  end
end
