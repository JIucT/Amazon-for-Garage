# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address1 ""
    address2 ""
    city ""
    country ""
    state ""
    zip_code ""
    mobile_number "MyString"
  end
end
