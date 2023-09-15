class Addcolumntomovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :release_date, :datetime
  end
end
