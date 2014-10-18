require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  include Devise::TestHelpers
  let(:user) { FactoryGirl.create :user }
  let(:address_params) do
    { address: {
      address1: Faker::Address.street_address,
      city: Faker::Address.city,
      country: Faker::Address.country,
      state: Faker::Address.state,
      zip_code: Faker::Address.zip_code,
      mobile_number: Faker::PhoneNumber.cell_phone }}
  end
  let(:email) { Faker::Internet.email }

  before do
    sign_in user
  end

  describe "POST #change_billing_address" do
    it "should render something wrong if unable to save new address" do
      post :change_billing_address, { address: { nothing: false } }
      expect(response).to render_template("shared/something_went_wrong")
    end

    it "should rendirect_to user/edit" do
      post :change_billing_address, address_params
      expect(response).to redirect_to(edit_user_registration_path)
    end

    it "should change user billing address" do
      old_address = user.billing_address
      post :change_billing_address, address_params
      expect(user.reload.billing_address).to_not match(old_address)
    end

    it "should not change addresses count" do
      expect {
        post :change_billing_address, address_params
      }.to_not change(Address, :count)
    end
  end

  describe "POST #change_shipping_address" do
    it "should render something wrong if unable to save new address" do
      post :change_shipping_address, { address: { nothing: false } }
      expect(response).to render_template("shared/something_went_wrong")
    end

    it "should rendirect_to user/edit" do
      post :change_shipping_address, address_params
      expect(response).to redirect_to(edit_user_registration_path)
    end

    it "should change user shipping address" do
      old_address = user.shipping_address
      post :change_shipping_address, address_params
      expect(user.reload.shipping_address).to_not match(old_address)
    end

    it "should not change addresses count" do
      expect {
        post :change_shipping_address, address_params
      }.to_not change(Address, :count)
    end
  end

  describe "POST #change_email" do
    it "should change user email" do
      old_email = user.email
      post :change_email, { email: { email: email }}
      expect(user.reload.email).to_not match(old_email)
    end 

    it "should render something wrong if unable to save user" do
      post :change_email, { email: { email: "" }}
      expect(response).to render_template("shared/something_went_wrong")
    end

    it "should rendirect_to user/edit" do
      post :change_email, { email: { email: email }}
      expect(response).to redirect_to(edit_user_registration_path)
    end    
  end

  describe "POST #change_password" do
    it "should render something wrong if unable to update user" do
      post :change_password, { password: { password: "abvders45",
        password_confirmation: "abvders44", current_password: "passsword" }}
      expect(response).to render_template("shared/something_went_wrong")
    end
  end  

end
