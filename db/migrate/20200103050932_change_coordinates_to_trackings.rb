class ChangeCoordinatesToTrackings < ActiveRecord::Migration[6.0]
  def up
    change_column :trackings, :coordinates, :st_point, null: false, geographic: true
  end

  def down
    change_column :trackings, :coordinates, :st_point, null: false
  end
end
