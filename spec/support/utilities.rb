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

def valid_sign_in(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end
