require 'rails_helper'

RSpec.describe Customer, :type => :model do
  let(:customer) { FactoryGirl.create(:customer) }

  context "validation" do
    it { expect(customer).to validate_presence_of(:email) }
    it { expect(customer).to validate_presence_of(:password_digest) }
    it { expect(customer).to validate_presence_of(:firstname) }
    it { expect(customer).to validate_presence_of(:lastname) }
    it { expect(customer).to validate_uniqueness_of(:email) }
  end

  context "relation" do
    it { expect(customer).to have_many(:orders) }
    it { expect(customer).to have_many(:ratings) }

    it "should be able to create a new order" do
      order = customer.orders.new(FactoryGirl.attributes_for(:order))
      expect(order.save).to eq(true)
    end

    it "should be able to return a current order" do
      orders = customer.orders.find_all
      expect(orders.count).to be >= 1
      expect(orders.to_a.at(0).class).to eq(Order)
    end
  end
end
