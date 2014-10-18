require 'rails_helper'

RSpec.describe BooksController, :type => :controller do
  let(:book) { FactoryGirl.create(:book) }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "renders index without layout if no_layout" do
      get :index, { no_layout: 'true' }
      expect(response).to render_template("index")
      expect(response).to render_template(layout: nil)
    end

    it "loads some books into @books" do
      book2 = FactoryGirl.create(:book)
      get :index
      expect(assigns(:books)).to match_array([book, book2])
    end

    it "should load authors of books" do
      author = FactoryGirl.create(:author)
      book.author_id = author.id
      book.save!
      get :index
      expect(assigns(:books).first.author).to match(author)      
    end
  end

  describe "GET #show" do
    include Devise::TestHelpers

    it "should find book by id with include rating and response successfully" do
      rating = FactoryGirl.create(:rating)
      rating.book_id = book.id
      rating.save!
      get :show, { id: book.id }
      expect(assigns(:book)).to match(book)
      expect(assigns(:book).ratings.first).to match(rating)
      expect(response).to be_success
      expect(response).to have_http_status(200)      
    end

    it "should set add_review to true if there is no review from current_user" do
      get :show, { id: book.id }
      expect(assigns(:add_review)).to match(true)
    end

    it "should set add_review to false if there is review from current_user" do
      rating = FactoryGirl.create(:rating)
      user = FactoryGirl.create(:user)
      sign_in user
      rating.book_id = book.id
      rating.user_id = user.id
      rating.save!      
      get :show, { id: book.id }
      expect(assigns(:add_review)).to match(false)
    end    
  end

  describe "GET #index_shop" do
    it "should render index_shop" do
      get :index_shop
      expect(response).to render_template('index_shop')
    end

    it "should render without layout if params[:no_layout]" do
      get :index_shop, { no_layout: 'true' }
      expect(response).to render_template(layout: nil)
    end

    it "should select books by category" do
      category = FactoryGirl.create(:category)
      book.category_id = category.id
      book.save!
      get :index_shop, { no_layout: 'true', locals: { category: category.title } }
      expect(assigns(:books).first).to match(book)
      expect(assigns(:books).first.category).to match(category)
    end

    it "should not select books from other categories" do
      category = FactoryGirl.create(:category)
      get :index_shop, { locals: { category: category.title } }
      expect(assigns(:books).first).to match(nil)
    end

  end
end
