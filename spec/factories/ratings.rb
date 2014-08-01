# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    comment Faker::Lorem.paragraph(1, true, 2)
    mark Faker::Number.digit.to_i
    customer nil
    book nil
  end
end
