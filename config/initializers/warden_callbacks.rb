Warden::Manager.before_logout do |user,auth,opts|
  user.forget_me!
  auth.cookies.delete :ordered_items
end