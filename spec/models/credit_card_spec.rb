require 'rails_helper'

RSpec.describe CreditCard, :type => :model do
  let(:credit_card) { FactoryGirl.create(:credit_card) }

  it { expect(credit_card).to validate_presence_of(:number) }
  it { expect(credit_card).to validate_presence_of(:expiration_date) }
  it { expect(credit_card).to validate_presence_of(:firstname) }
  it { expect(credit_card).to validate_presence_of(:lastname) }

  it { expect(credit_card).to belong_to(:customer) }
  it { expect(credit_card).to have_many(:orders) }
end
