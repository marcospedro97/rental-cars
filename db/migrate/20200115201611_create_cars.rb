# frozen_string_literal: true

class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :license_plate
      t.string :color
      t.references :subsidiary, foreign_key: true
      t.references :car_model, foreign_key: true
      t.string :mileage

      t.timestamps
    end
  end
end
