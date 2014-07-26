# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item do
    price Faker::Number.decimal(2).to_f
    quantity Faker::Number.digit.to_f
  end
end
