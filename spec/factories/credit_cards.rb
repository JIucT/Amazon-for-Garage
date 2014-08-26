# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit_card do
    number { Faker::Business.credit_card_number }
    expiration_date { Faker::Business.credit_card_expiry_date }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }

    after(:create) do |credit_card|
      create_list(:order, Faker::Number.digit.to_i + 1, credit_card: credit_card)
    end
  end
end
