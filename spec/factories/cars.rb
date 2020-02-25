FactoryBot.define do
  factory :car do
    license_plate { 'ABC-1234' }
    color { 'Azul' }
    car_model
    mileage { 102 }
    subsidiary
    status { :available }
  end
end
