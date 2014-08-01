# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    total_price Faker::Number.decimal(2).to_f
    completed_at DateTime.now - Faker::Number.number(3).to_i.days
    state ['in progress', 'complited', 'shipped'][Random::rand(3)]
    billing_address_id FactoryGirl.create(:address).id
    shipping_address_id FactoryGirl.create(:address).id

    after(:create) do |order|
      create_list(:order_item, Faker::Number.digit.to_i + 1, order: order, book: create(:book))
    end
  end
end
