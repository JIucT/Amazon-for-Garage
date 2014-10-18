require 'rails_helper'

RSpec.describe RatingsController, :type => :controller do
  include Devise::TestHelpers
  let(:user) { FactoryGirl.create :user }
  let(:valid_attributes) do
    { rating: { comment: Faker::Lorem.paragraph(1, true, 2),
                mark: Random::rand(6),
                title: Faker::Company.name }}
  end

  before do
    sign_in user
  end

  describe "POST create" do
    it "returns http success" do
      post :create, valid_attributes
      expect(response).to be_success
    end

    it "renders create without layout" do
      post :create, valid_attributes
      expect(response).to render_template("create")
      expect(response).to render_template(layout: nil)
    end

    it "store new rating in @rating" do
      post :create, valid_attributes
      expect(assigns(:rating).class).to match(Rating)
      expect(assigns(:rating).user_id).to match(user.id)
    end
  end
end
