class RenameColumnNamesInJoggingSessionsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :jogging_sessions, :time, :duration_in_minutes
    rename_column :jogging_sessions, :date, :jogging_started_at
    rename_column :jogging_sessions, :distance, :distance_in_meters
  end
end
