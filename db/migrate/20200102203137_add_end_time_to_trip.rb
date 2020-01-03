class AddEndTimeToTrip < ActiveRecord::Migration[6.0]
  def up
    add_column :trips, :end_time, :datetime
    rename_column :trips, :time, :start_time
  end

  def down
    remove_column :trips, :end_time
    rename_column :trips, :start_time, :time
  end
end
