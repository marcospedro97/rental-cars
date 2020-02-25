class AddStatusToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :status, :integer
  end
end
