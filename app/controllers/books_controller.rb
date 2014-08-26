class BooksController < ApplicationController
#  before_action :authenticate_user!, only: :add_order_item
  def index
    @books = Book.limit(20).order('updated_at DESC').includes(:author)
    if params[:no_layout] == 'true'
      render 'index', layout: false
    end
  end

  def show
    @book = Book.includes(:ratings).find(params[:id])
    @status = 2321
  end

  def add_order_item
    # if session[:ordered_books_ids].nil?
    #   session[:ordered_books_ids] = 
    # if !authenticate_user!
    #   redirect_to 'users/sign_in'
    # end
    # if current_user.current_order_id.nil?
    #   current_user.current_order_id = Order.create().id
    # end    
    # @book = Book.includes(:ratings).find(params[:id])
    # OrderItem.create(price: @book.price, quantity: params[:quantity],
    #     book_id: @book.id, order_id: current_user.current_order_id)
    # render 'show'    

  end

  def index_shop
    active_page = 1
    unless (params[:active_page].nil? || params[active_page] == '')
      active_page = params[:active_page].to_i 
    end
    if !params[:category].nil? && params[:category] != ''
      @books = Book.get_books_by_category()
      Book.joins(:category).where(categories: { title: params[:category] })
                   .limit(9).offset( (active_page-1)*9 ).order('price ASC')
      pages_number = Book.joins(:category)
      .where(categories: { title: params[:category] }).count(:all)
      category = params[:category]
    else
      @books = Book.limit(9).offset( (active_page-1)*9 ).order('price ASC')
      pages_number = Book.count(:all)      
    end
    pages_number = (pages_number / 9.0).ceil
    if params[:no_layout] == 'true'
      render 'index_shop', layout: false,
        locals: { active_page: active_page, pages_number: pages_number, category: category }
    else
      render 'index_shop',
        locals: { active_page: active_page, pages_number: pages_number, category: category }
    end
  end

end
