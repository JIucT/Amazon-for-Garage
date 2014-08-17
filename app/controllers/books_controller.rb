class BooksController < ApplicationController

  def index
    @books = Book.limit(20).order('updated_at DESC').includes(:author)
    Rails.logger.debug params
    if params[:no_layout] == 'true'
      render 'index', layout: false
    end
  end

  def index_shop
    offset = params[:books_offset] || 0
    @books = Book.limit(9).offset(offset.to_i).order('price DESC')
    if params[:no_layout] == 'true'
      render 'index_shop', layout: false
    end
  end

end
