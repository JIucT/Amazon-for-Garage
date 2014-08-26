class RemoveDefaultFromRatingsTitle < ActiveRecord::Migration
  def change
    change_column_default(:ratings, :title, nil)
  end
end
