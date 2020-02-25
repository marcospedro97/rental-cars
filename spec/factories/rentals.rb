FactoryBot.define do
    factory :rental do
      code { 'XX000' }
      start_date { Date.current }
      end_date { 10.days.from_now }
      client
      car_category
      status { :scheduled }
    end
  end
  