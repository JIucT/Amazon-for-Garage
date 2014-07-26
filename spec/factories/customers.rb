# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    password_digest Faker::Internet.password(8)
    email Faker::Internet.email
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name

    after(:create) do |customer|
      create_list(:order, Faker::Number.digit.to_i, customer: customer)
      create_list(:rating, Faker::Number.digit.to_i, customer: customer)
      create(:credit_card, customer: customer)
    end
  end
end
