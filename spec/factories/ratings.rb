# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    comment ""
    mark ""
    customer ""
    book nil
  end
end
