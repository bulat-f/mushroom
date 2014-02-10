def full_title(page_title)
  base_title = 'Mushroom'
  if page_title.empty?
    base_title
  else
    "#{ base_title } | #{ page_title }"
  end
end

def valid_sign_up()
  fill_in "Surname",      with: "Exampler"
  fill_in "Name",         with: "User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Phone",        with: "+79655925240"
  fill_in "Password",     with: "foobartoo"
  fill_in "Confirmation", with: "foobartoo"
end

def sign_in(user, options = {})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

def edit_user_attr(user, new_attr = {})
  fill_in "Surname",      with: new_attr[:surname] || user.surname
  fill_in "Name",         with: new_attr[:name] || user.name
  fill_in "Email",        with: new_attr[:email] || user.email
  fill_in "Phone",        with: new_attr[:phone] || user.phone
  fill_in "Password",     with: new_attr[:password] || user.password
  fill_in "Confirmation", with: new_attr[:password_confirmation] || user.password
end
