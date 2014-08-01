require 'rails_helper'

RSpec.describe Address, :type => :model do
  let(:address) { FactoryGirl.create(:address) }

  context "validations" do
    it { expect(address).to validate_presence_of(:address1) }
    it { expect(address).to validate_presence_of(:address2) }
    it { expect(address).to validate_presence_of(:city) }
    it { expect(address).to validate_presence_of(:country) }
    it { expect(address).to validate_presence_of(:state) }
    it { expect(address).to validate_presence_of(:zip_code) }
    it { expect(address).to validate_presence_of(:mobile_number) }
  end
end
