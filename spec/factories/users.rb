# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    password { Faker::Internet.password(9) }
    sign_in_count { Random::rand(359) }

    after(:create) do |user|
      create_list(:order, Faker::Number.digit.to_i + 1, user: user)
      create_list(:rating, Faker::Number.digit.to_i + 1, user: user)
      create(:credit_card, user: user)
    end
  end
end
