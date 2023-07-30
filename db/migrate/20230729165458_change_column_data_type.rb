class ChangeColumnDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :jogging_sessions, :duration_in_minutes, :float, precision: 10, scale: 2, using: 'extract(epoch from duration_in_minutes)::float'
    change_column :jogging_sessions, :distance_in_meters, :integer, using: 'distance_in_meters::integer'
  end
end
