require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  include Devise::TestHelpers
  let(:user) { FactoryGirl.create :user }
  let(:order) { FactoryGirl.create :order }
  let(:book) { FactoryGirl.create(:book) }  

  before do
    sign_in user
    order.update(user_id: user.id)
  end

  describe "GET #show" do    
    it "should find order by params[id] and include its order_items" do
      get :show, { id: order.id }
      expect(assigns(:order)).to match(order)
      expect(assigns(:ordered_items)).to match(order.order_items)
    end

    it "should set shipping price dependent on shipping type" do
      order.shipping_type = "UPS Ground"
      order.save!
      get :show, { id: order.id }
      expect(assigns(:shipping_price)).to match(5)
      order.shipping_type = "UPS Two Days"
      order.save!
      get :show, { id: order.id }
      expect(assigns(:shipping_price)).to match(10)
      order.shipping_type = "UPS One Day"
      order.save!
      get :show, { id: order.id }
      expect(assigns(:shipping_price)).to match(15)      
    end

    it "should select ordered books" do
      get :show, { id: order.id }
      expect(assigns(:items)).to match(Book.where(id: order.order_items.pluck(:id)).load)
    end

    it "should create array of ordered books quantity" do
      get :show, { id: order.id }
      expect(assigns(:qty)).to match_array(order.order_items.pluck(:quantity))
    end

    it "renders the show template" do
      get :show, { id: order.id }
      expect(response).to render_template("show")
    end    

    it "should raise exception if order dosn't belongs to current user" do
      order.update(user_id: user.id.next)
      expect {
        get :show, { id: order.id }
      }.to raise_error('Not Found')
    end
  end

  describe "GET #index" do
    before(:each) do
      order.update!(user_id: user.id)
    end

    it "should get orders in progress" do
      order.update!(state: 'in progress')
      get :index
      expect(assigns(:orders_in_progress)).to include(order)
    end

    it "should get orders in delivery" do
       order.update!(state: 'in delivery')
      get :index
      expect(assigns(:orders_in_delivery)).to include(order)
    end    

    it "should get delivered orders" do
      order.update!(state: 'delivered')
      get :index
      expect(assigns(:orders_delivered)).to include(order)
    end    

    it "should has no orders if no orders" do
      Order.where(user_id: user.id).delete_all
      get :index
      expect(assigns(:has_no_orders)).to match(true)
    end

    it "should has array of ordered books, quantity and total price" do
      book1 = FactoryGirl.create(:book)
      book2 = FactoryGirl.create(:book)
      request.cookies['ordered_items'] = "#{book1.id}|3,#{book2.id}|5,"
      get :index
      expect(assigns(:total)).to match(book1.price*3 + book2.price*5)
      expect(assigns(:items)).to match_array([book1, book2])
      expect(assigns(:qty)).to match_array(['3', '5'])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    let(:order_params) do
      { order: {
        card_exp_year: (Random::rand(10)+2015).to_s,
        card_exp_month: '05', 
        card_number: Faker::Business.credit_card_number,
        ship_country: Faker::Address.country, 
        ship_zip: Faker::Address.zip, 
        ship_city: Faker::Address.city, 
        ship_street: Faker::Address.street_address, 
        bil_mobile: Faker::PhoneNumber.cell_phone, 
        bil_country: Faker::Address.country, 
        bil_zip: Faker::Address.zip,
        bil_city: Faker::Address.city, 
        bil_street: Faker::Address.street_address, 
        total_price: Faker::Commerce.price, 
        shipping_type: ['UPS Ground', 'UPS Two Days', 'UPS One Day'][Random::rand(3)]
      }}
    end

    before(:each) do
      request.cookies['ordered_items'] = "#{book.id}|3,"
    end

    it "responds successfully with an HTTP 200 status code" do
      post :create, order_params
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should delete cookie" do
      post :create, order_params
      expect(response.cookies['ordered_items']).to match(nil)
    end

    it "should create two addresses" do
      expect {
        post :create, order_params
      }.to change(Address, :count).by(2)
    end

    it "should create credit card" do
      expect {
        post :create, order_params
      }.to change(CreditCard, :count).by(1)
    end    

    it "should create order item" do
      expect {
        post :create, order_params
      }.to change(OrderItem, :count).by(1)
    end 

    it "shold create order item from cookies" do
      post :create, order_params
      item = OrderItem.order("updated_at DESC").first
      expect(item.price).to match(book.price)
      expect(item.quantity).to match(3)
      expect(item.book_id).to match(book.id)
    end

    it "should create order for user" do
      expect {
        post :create, order_params
      }.to change(user.orders, :count).by(1)
    end    

    it "should create correct order" do
      post :create, order_params
      order = Order.order("updated_at DESC").first
      expect(order.total_price).to match(order_params[:order][:total_price].to_d)
      expect(order.state).to match("in progress")
      expect(order.user_id).to match(user.id)      
    end
  end

  describe "GET #checkout" do  
    it "should redirect to index shop if no cookies" do
      get :checkout
      expect(response).to redirect_to(index_shop_books_path)
    end

    context "with cookies" do
      before(:each) do        
        request.cookies['ordered_items'] = "#{book.id}|3,"
      end

      it "should store user first and last names" do
        get :checkout
        expect(assigns(:first_name)).to match(user.firstname)
        expect(assigns(:last_name)).to match(user.lastname)
      end

      it "should store user billing address" do
        get :checkout
        addr = user.billing_address
        expect(assigns(:street)).to match(addr.address1)
        expect(assigns(:zip)).to match(addr.zip_code)
        expect(assigns(:country)).to match(addr.country)
      end

      it "should create assigns from cookies" do
        extra_book = FactoryGirl.create(:book)
        request.cookies['ordered_items'] += "#{extra_book.id}|5,"
        get :checkout
        expect(assigns(:items)).to match_array([book, extra_book])
        expect(assigns(:qty)).to match_array(['3', '5'])
        expect(assigns(:total)).to match(book.price*3 + extra_book.price*5)
      end

      it "shoud render checkout" do
        get :checkout
        expect(response).to render_template(:checkout)
      end
    end
  end

  describe "GET #cart" do
    let(:extra_book) { FactoryGirl.create(:book) }
    before(:each) do        
      request.cookies['ordered_items'] = "#{book.id}|3,#{extra_book.id}|5,"
    end

    it "should create assigns from cookies" do
      get :cart
      expect(assigns(:items)).to match_array([book, extra_book])
      expect(assigns(:qty)).to match_array(['3', '5'])
      expect(assigns(:total)).to match(book.price*3 + extra_book.price*5)
    end

    it "shoud render cart" do
      get :cart
      expect(response).to render_template(:cart)
    end    
  end
end
