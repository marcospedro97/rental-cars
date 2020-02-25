# frozen_string_literal: true

class AddStatusToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :status, :integer, default: 0, null: 0
  end
end
