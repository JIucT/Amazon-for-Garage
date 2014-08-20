class BooksController < ApplicationController

  def index
    @books = Book.limit(20).order('updated_at DESC').includes(:author)
    Rails.logger.debug params
    if params[:no_layout] == 'true'
      render 'index', layout: false
    end
  end

  def index_shop
    active_page = 1
    active_page = params[:active_page].to_i unless 
                          (params[:active_page].nil? || params[active_page] == '')
    if !params[:category].nil? && params[:category] != ''
      @books = Book.joins(:category).where(categories: { title: params[:category].gsub('_',' ') })
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
