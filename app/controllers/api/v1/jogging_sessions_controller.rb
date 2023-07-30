class Api::V1::JoggingSessionsController < ApiController
  before_action :set_jogger, only: %i[show update destroy]

  def index
    from = date_safe_parse(params[:from])
    to = date_safe_parse(params[:to])
    should_apply_date = from.present? && to.present?
    if can? :manage, :all
      @jogging_sessions = JoggingSession.all unless should_apply_date
      @jogging_sessions = JoggingSession.where(jogging_started_at: from..to) if should_apply_date
    else
      @jogging_sessions = current_user.jogging_sessions.all unless should_apply_date
      @jogging_sessions = current_user.jogging_sessions.where(jogging_started_at: from..to) if should_apply_date
    end
    render json: @jogging_sessions, status: :ok
  end

  def show
    render json: { data: @jogging_session, status: 'success' }, status: :ok
  end

  def create
    @jogging_session = current_user.jogging_sessions.new(jogging_params)
    if @jogging_session.save
      render json: { data: @jogging_session, message: 'jogging session created successfully', status: 'success' },
             status: :created
    else
      render json: { data: @jogging_session.errors.full_messages, message: 'Failed to create new jogging session' },
             status: :unprocessable_entity
    end
  end

  def update
    if @jogging_session.update(jogging_params)
      render json: @jogging_session, status: :ok
    else
      render json: { data: @jogging_session.errors.full_messages, message: 'Failed to update existing jogging session' },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @jogging_session.destroy
      render json: { data: @jogging_session, status: 'success', message: 'jogging session is deleted successfully' },
             status: :ok
    else
      render json: { data: 'Something went wrong', message: 'failed' }, status: :not_found
    end
  end

  def report
    user_id = current_user.id # Replace with the user ID you want to filter by
    period = params[:period] # "week" or "month" parameter from the route

    if %w[weekly monthly].include?(period)
      period_mapping = { 'weekly' => 'week', 'monthly' => 'month' }
      date_trunc = period_mapping[period]
    else
      render json: { error: "Invalid period parameter. Use 'weekly' or 'monthly'." }, status: :unprocessable_entity
      return
    end

    @report = JoggingSession
      .select("DATE_TRUNC('#{date_trunc}', jogging_started_at) AS period_start, AVG(distance_in_meters / duration_in_minutes) AS average_speed, AVG(distance_in_meters) AS average_distance")
      .where(user_id: user_id) # Add the WHERE clause to filter by user_id
      .group('period_start')
      .order('period_start')

    render json: { data: @report, status: 'success', message: 'Report data is successfully created' }
  end

  private

  def set_jogger
    # @jogging_session = JoggingSession.find(params[:id])
    @jogging_session = current_user.jogging_sessions.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: e.message, status: :unauthorized
  end

  def jogging_params
    params.require(:jogging).permit(:distance_in_meters, :duration_in_minutes, :jogging_started_at)
  end
end
