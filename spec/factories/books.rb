# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(2, false, 4) }
    price { Faker::Number.decimal(2).to_f }
    in_stock { Faker::Number.number(2).to_i }
    author nil
    category nil
  end
end
