FactoryBot.define do
  factory :car_category do
    name { 'A' }
    daily_rate { 99 }
    car_insurance { 1000 }
    third_party_insurance { 1499 }
  end
end
