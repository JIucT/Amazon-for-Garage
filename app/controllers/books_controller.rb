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
    active_page = params[:active_page].to_i unless params[:active_page].nil?
    if !params[:category].nil?
      @books = Book.joins(:category).where(categories: { title: params[:category].gsub('_',' ') })
                   .limit(9).offset( (active_page-1)*9 ).order('price DESC')
    else
      @books = Book.limit(9).offset( (active_page-1)*9 ).order('price DESC')
    end
    if params[:no_layout] == 'true'
      render 'index_shop', locals: { active_page: active_page }, layout: false
    else
      render 'index_shop', locals: { active_page: active_page }
    end
  end

end
