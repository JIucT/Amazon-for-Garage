feature "Book actions" do
  background do 
    login_as(FactoryGirl.create(:user))
  end

  let(:book) { FactoryGirl.create(:book) }

  before(:each) do
    visit book_path(book)    
  end
  
  scenario "Visitor adds new book to cart", js: true do
    expect(find("#cart-status")).to have_content("EMPTY")
    fill_in 'book-qty', with: '3'
    click_button 'add-to-cart'
    expect(find("#cart-status")).to have_content("1")
  end

  scenario "Visitor adds book review", js: true do
    long_review = "Capybara helps you test web applications by simulating 
      how a real user would interact with your app. It is agnostic about the driver 
      running your tests and comes with Rack::Test and Selenium support built in. 
      WebKit is supported through an external gem."
    click_link 'add-review'
    within '#review-form' do
      page.execute_script('$(\'input[type="radio"].star\').rating(\'select\', 3)')
      fill_in 'short-feedback', with: 'Very nice'
      fill_in 'comment', with: long_review
      click_button 'send-review'
    end
    sleep(1)    #makes webkit to wait ajax response
    expect(first(".well")).to have_content(long_review)
    expect(first(".row")).to have_content('Very nice')
    expect(page).not_to have_content('Add review')
  end  
end

