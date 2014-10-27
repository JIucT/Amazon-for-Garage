require 'rails_helper'
require "cancan/matchers"
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
    it { expect(user).to belong_to(:billing_address) }
    it { expect(user).to belong_to(:shipping_address) }

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
  
  context "abilities" do
    describe "when is common user" do
      let(:ability) { Ability.new(user) }

      it { expect(ability).to be_able_to(:read, Order.new(user: user)) }
      it { expect(ability).not_to be_able_to(:access, :rails_admin) }
    end

    describe "when is admin" do
      before(:each) do
        user.update(is_admin: true)
        @ability = Ability.new(user)
      end
      it { expect(@ability).to be_able_to(:manage, :all) }
      it { expect(@ability).to be_able_to(:access, :rails_admin) }      
    end
  end  
end
