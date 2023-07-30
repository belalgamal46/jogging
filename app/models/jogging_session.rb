class JoggingSession < ApplicationRecord
  belongs_to :user

  validates_presence_of :distance_in_meters, :duration_in_minutes, :jogging_started_at
end
