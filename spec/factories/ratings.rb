# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    comment { Faker::Lorem.paragraph(1, true, 2) }
    mark { Random::rand(6) }
    title { Faker::Company.name }
    user nil
    book nil
  end
end
