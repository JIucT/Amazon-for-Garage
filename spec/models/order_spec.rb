require 'rails_helper'

RSpec.describe Order, :type => :model do
  let(:order) { FactoryGirl.create(:order) }

  context "validations" do
    it { expect(order).to validate_presence_of(:total_price) }
    it { expect(order).to validate_presence_of(:completed_at) }
    it { expect(order).to validate_presence_of(:state) }

  end

  it "should have a state" do
    expect(order.state).to be_in(['in progress', 'complited', 'shipped'])
  end

  it "should have default state" do
    expect(Order.create(FactoryGirl.attributes_for(:order).delete('state')).state).to be_eql('in progress')
  end

  context "relations" do
    it { expect(order).to belong_to(:customer) }
    it { expect(order).to belong_to(:credit_card) }
    it { expect(order).to belong_to(:billing_address) }
    it { expect(order).to belong_to(:shipping_address) }
    it { expect(order).to have_many(:order_items) }

    it "should be able to add a book to the order" do
      order_item = order.order_items.create(FactoryGirl.attributes_for(:order_item))
      order_item.book = FactoryGirl.create(:book)
      expect(order_item.save).to eq(true)
    end
  end
end
