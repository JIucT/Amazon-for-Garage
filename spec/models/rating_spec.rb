require 'rails_helper'

RSpec.describe Rating, :type => :model do
  let(:rating) { FactoryGirl.create(:rating) }

  it { expect(rating.mark).to be_between(0, 10).inclusive }
  it { expect(rating).to belong_to(:customer) }
  it { expect(rating).to belong_to(:book) }
end
