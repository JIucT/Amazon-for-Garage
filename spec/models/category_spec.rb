require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:category) { FactoryGirl.create(:category) }

  it { expect(category).to validate_presence_of(:title) }
  it { expect(category).to validate_uniqueness_of(:title) }
  it { expect(category).to have_many(:books) }
end
