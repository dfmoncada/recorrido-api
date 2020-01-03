class AddTimeToTrackings < ActiveRecord::Migration[6.0]
  def up
    add_column :trackings, :time, :datetime, null: false
  end

  def down
    remove_column :trackings, :time
  end
end
