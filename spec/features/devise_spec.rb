feature "Devise actions" do
  scenario "Visitor registers successfully via register form" do
    visit index_shop_books_path
    click_link 'Sign up'
    within '#login-form' do
      fill_in 'firstname', with: Faker::Name.first_name
      fill_in 'lastname', with: Faker::Name.last_name
      fill_in 'email', with: Faker::Internet.email
      fill_in 'password-confirmation', with: '123qwertyuip1'
      fill_in 'password', with: '123qwertyuip1'
      click_button('submit-login')
    end
    expect(page).not_to have_content 'Sign up'
    expect(page).not_to have_content 'Sign in'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Settings'
    expect(page).to have_content 'Orders'
    expect(page).to have_content 'SHOP BY CATEGORIES'
  end

  scenario "Visitor log in successfully via log in form" do
    user = User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name,
      email: Faker::Internet.email, password_confirmation:'123qwertyuip1', password: '123qwertyuip1')
    visit index_shop_books_path
    click_link 'Sign in'
    within '#login-form' do
      fill_in 'email', with: user.email
      fill_in 'password', with: '123qwertyuip1'
      click_button('submit-login')
    end
    expect(page).not_to have_content 'Sign in'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Settings'
    expect(page).to have_content 'Orders'
    expect(page).to have_content 'SHOP BY CATEGORIES'
  end  

  scenario "Visitor log out successfully" do
    login_as(FactoryGirl.create(:user))
    visit index_shop_books_path
    click_link 'Sign out'
    expect(page).not_to have_content 'Sign out'
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Sign up'
    expect(current_path).to match(root_path)
  end  
end

