class AddMileageToCarRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :car_rentals, :mileage, :string
  end
end
