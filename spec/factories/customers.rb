# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    password ""
    email ""
    firstname ""
    lastname "MyString"
  end
end
