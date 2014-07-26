require 'rails_helper'

RSpec.describe OrderItem, :type => :model do
  let(:order_item) { FactoryGirl.create(:order_item)}

  it { expect(order_item).to validate_presence_of(:price) }
  it { expect(order_item).to validate_presence_of(:quantity) }

  it { expect(order_item).to belong_to(:book) }
  it { expect(order_item).to belong_to(:order) }
end
