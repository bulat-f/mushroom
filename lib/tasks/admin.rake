namespace :db do
  desc "Create admin user"
  task create_admin: :environment do
    admin = User.create!(surname: "Admin", name: "Admin", email: "fatbulat5@gmail.com", phone: "+79655925240", tutor: true, admin: true, password: "foobar", password_confirmation: "foobar")
  end
end
