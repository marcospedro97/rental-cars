FactoryBot.define do
  factory :car_model do
    name { 'Prius' }
    year { '2012' }
    motorization { '1.0' }
    fuel_type { 'Flex' }
    car_category
    manufacturer
  end
end
