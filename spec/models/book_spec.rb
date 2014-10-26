require 'rails_helper'

RSpec.describe Book, :type => :model do
  let(:book) { FactoryGirl.create(:book) }

  context "validations" do
    it { expect(book).to validate_presence_of(:title) }
    it { expect(book).to validate_presence_of(:author_id) }
    it { expect(book).to validate_presence_of(:price) }
    it { expect(book).to validate_presence_of(:in_stock) } 
  end

  context "relations" do
    it { expect(book).to belong_to(:author) }
    it { expect(book).to belong_to(:category) }
  end
end
