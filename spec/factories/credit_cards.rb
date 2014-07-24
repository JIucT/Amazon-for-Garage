# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit_card do
    number "MyString"
    expiration_date "2014-07-24 18:43:59"
    firstname "MyString"
    lastname "MyString"
  end
end
