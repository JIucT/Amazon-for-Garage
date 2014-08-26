# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :author do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    biography { Faker::Lorem.paragraph(3, true, 2) }
  end
end
