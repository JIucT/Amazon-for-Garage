# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    total_price ""
    completed_at ""
    state "MyString"
  end
end
