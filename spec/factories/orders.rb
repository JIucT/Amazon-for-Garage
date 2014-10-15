# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    total_price Faker::Number.decimal(2).to_f
    state ['in progress', 'delivered', 'in delivery'][Random::rand(3)]
    shipping_type ['UPS Ground', 'UPS Two Days', 'UPS One Day'][Random::rand(3)] 
    billing_address_id { FactoryGirl.create(:address).id }
    shipping_address_id { FactoryGirl.create(:address).id }    

    after(:create) do |order|
      create_list(:order_item, Faker::Number.digit.to_i + 1, order: order, book: create(:book))
    end
  end
end
