class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.order_items
    @items = Array.new
    @qty = Array.new
    case @order.shipping_type
    when 'UPS Ground'
      @shipping_price = 5
    when 'UPS Two Days'
      @shipping_price = 10
    when 'UPS One Day'
      @shipping_price = 15
    else
      @shipping_price = 0
    end
    @ordered_items.each do |i|
      @items.push(Book.find(i.book_id))
      @qty.push(i.quantity)
    end
  end

  def index
    @total = 0
    @items = Array.new
    @qty = Array.new    
    if cookies['ordered_items']
      cookies['ordered_items'].split(',').each do |item|
        order_item = item.split('|')
        book = Book.find(order_item[0])
        @items.push(book)
        @qty.push(order_item[1])
        @total += book.price * order_item[1].to_i
      end      
    end
    @orders_in_progress = Order.where(user_id: current_user.id, state: 'in progress')
    @has_no_orders = Order.where(user_id: current_user.id, state: ['in progress', 'in delivery', 'delivered']).empty?
    @orders_in_delivery = Order.where(user_id: current_user.id, state: 'in delivery')
    @orders_delivered = Order.where(user_id: current_user.id, state: 'delivered')
  end

  def create
    bil_address = Address.new({ address1: order_params[:bil_street], city: order_params[:bil_city], 
      country: order_params[:bil_country], zip_code: order_params[:bil_zip],
      mobile_number: order_params[:bil_mobile] })
    unless bil_address.save
      render "shared/shared/something_went_wrong"
    end
    ship_address = Address.new({  address1: order_params[:ship_street],
     city: order_params[:ship_city], country: order_params[:ship_country],
     zip_code: order_params[:ship_zip] })
    unless ship_address.save
      render "shared/shared/something_went_wrong"
    end    
    credit_card = CreditCard.new({ number: order_params[:card_number],
     expiration_date: Date.new(order_params[:card_exp_year].to_i, order_params[:card_exp_month].to_i, 1),
     user_id: current_user.id })
    unless credit_card.save!
      render "shared/shared/something_went_wrong"
    end    
    order = Order.new({ total_price: order_params[:total_price].to_d,
      billing_address_id: bil_address.id, shipping_address_id: ship_address.id,
        user_id: current_user.id, credit_card_id: credit_card,
        shipping_type: order_params[:shipping_type] })
    unless order.save!
      render "shared/shared/something_went_wrong"
    end
    cookies[:ordered_items].split(',').each do |item|
      book_id = item.split('|')[0].to_i
      qty = item.split('|')[1].to_i
      order_item = OrderItem.new({ order_id: order.id, book_id: book_id,
      quantity: qty, price: Book.find(book_id).price })
      order_item.save!
    end
    cookies.delete :ordered_items, path: '/'
    render :js => "window.location = '#{index_shop_books_path}'"
  end

  def checkout
    if !cookies['ordered_items']
      redirect_to index_shop_books_path 
    end 
    user = current_user
    address = current_user.billing_address
    @first_name = user.firstname
    @last_name = user.lastname
    unless address.nil?
      @street = address.address1
      @city = address.city
      @zip = address.zip_code
      @phone_number = address.mobile_number
      @country = address.country
    end
    @total = 0
    @items = Array.new
    @qty = Array.new
    if cookies['ordered_items']
      cookies['ordered_items'].split(',').each do |item|
        order_item = item.split('|')
        book = Book.find(order_item[0])
        @items.push(book)
        @qty.push(order_item[1])
        @total += book.price * order_item[1].to_i
      end      
    end
  end

  def cart 
    @total = 0
    @items = Array.new
    @qty = Array.new
    if cookies['ordered_items']
      cookies['ordered_items'].split(',').each do |item|
        order_item = item.split('|')
        book = Book.find(order_item[0])
        @items.push(book)
        @qty.push(order_item[1])
        @total += book.price * order_item[1].to_i
      end
    end
  end

private

  def order_params
    params.require(:order).permit(:card_exp_year, :card_exp_month, :card_number,
      :ship_country, :ship_zip, :ship_city, :ship_street, :bil_mobile, :bil_country, :bil_zip,
      :bil_city, :bil_street, :total_price, :shipping_type)
  end  
end
