class CreateJoggingSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :jogging_sessions do |t|
      t.string :distance, null: false
      t.datetime :time, null: false
      t.datetime :date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
