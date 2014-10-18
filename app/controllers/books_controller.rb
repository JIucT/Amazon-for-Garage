class BooksController < ApplicationController

  def index
    @books = Book.limit(20).order('updated_at DESC').includes(:author)
    if params[:no_layout] == 'true'
      render 'index', layout: false
    end
  end

  def show
    @book = Book.includes(:ratings).order('ratings.updated_at DESC').find(params[:id])
    @add_review = true
    @book.ratings.each do |rating|
      if current_user && rating.user_id == current_user.id
        @add_review = false
      end
    end
  end

  def index_shop
    active_page = 1
    unless (params[:active_page].nil? || params[active_page] == '')
      active_page = params[:active_page].to_i 
    end
    if !params[:category].nil? && params[:category] != ''
      @books = Book.joins(:category).where(categories: { title: params[:category] })
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
