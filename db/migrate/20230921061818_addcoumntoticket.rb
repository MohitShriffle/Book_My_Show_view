class Addcoumntoticket < ActiveRecord::Migration[7.0]
  def change
    add_column :shows, :price, :integer
  end
end
