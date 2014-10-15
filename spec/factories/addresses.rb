# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address1 { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country}
    state { Faker::Address.state }
    zip_code { Faker::Address.zip_code }
    mobile_number { Faker::PhoneNumber.cell_phone }
  end
end
