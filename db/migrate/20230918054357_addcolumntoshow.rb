class Addcolumntoshow < ActiveRecord::Migration[7.0]
  def change
    add_column :shows, :start_time, :string
    add_column :shows, :end_time, :string
  end
end
