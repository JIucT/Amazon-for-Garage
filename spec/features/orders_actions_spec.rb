feature "Orders actions" do
  background do 
    login_as(FactoryGirl.create(:user))
  end

  let(:book1) { FactoryGirl.create(:book) }
  let(:book2) { FactoryGirl.create(:book) }

  before(:each) do
    visit book_path(book1)
    fill_in 'book-qty', with: '3'
    click_button 'add-to-cart'
    visit book_path(book2)
    click_button 'add-to-cart'
  end
  
  scenario "Visitor adds order", js: true do
    click_link 'CART'
    expect(page).to have_content(book1.title)
    expect(page).to have_content(book2.title)
    expect(page).to have_content('SUBTOTAL')
    expect(page).to have_button('CHECKOUT')
  end

  scenario "Visitor checkout", js: true do
    visit checkout_orders_path
    within '#bil-addr' do
      fill_in 'firstname', with: 'Eugene'
      fill_in 'lastname', with: 'Grigorenko'
      fill_in 'bill-st-addr', with: 'Pensilvania ave. 65, apt. 1036'
      fill_in 'bill-city-addr', with: 'Washington'
     # find("option[value='United States']").click
      execute_script('$(".countries-select").val("United States");')
      fill_in 'bill-zip', with: '33229'
      fill_in 'bill-phone', with: '1 110 256 312'
    end
    click_button 'to-delivery'
    find("[name='delivery'][value='10.00']").click
    click_button 'Next'
    within '#paymant' do
      fill_in 'credit-card', with: Faker::Business.credit_card_number
      #find("option[value='07']").click
      execute_script('$("#card-exp-month").val("07");')
      #find("option[value='2023']").click
      execute_script('$("#card-exp-year").val("2023");')
      fill_in 'CVC', with: '123'
    end
    click_button 'Next'
    expect(page).to have_content(book1.title)
    expect(page).to have_content(book2.title)    
    expect(page).to have_content('ORDER TOTAL')
    expect(page).to have_button('Previous')
    click_button 'Confirm'
    sleep(1)
    expect(current_path).to match(index_shop_books_path)
  end
end

