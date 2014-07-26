# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "MyString"
    description "MyText"
    price "9.99"
    in_stock 1
    author nil
    category nil
  end
end
