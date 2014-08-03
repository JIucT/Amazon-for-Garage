require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  context "validation" do
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_presence_of(:firstname) }
    it { expect(user).to validate_presence_of(:lastname) }
    it { expect(user).to validate_uniqueness_of(:email) }
  end

  context "relation" do
    it { expect(user).to have_many(:orders) }
    it { expect(user).to have_many(:ratings) }

    it "should be able to create a new order" do
      order = user.orders.new(FactoryGirl.attributes_for(:order))
      expect(order.save).to eq(true)
    end

    it "should be able to return a current order" do
      orders = user.orders.find_all
      expect(orders.count).to be >= 1
      expect(orders.to_a.at(0).class).to eq(Order)
    end
  end
end
