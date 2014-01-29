namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         phone_number: "516-680-8605",
                         company_id: 1,
                         alpine_user: false,
                         entitled: true,
                         company_admin: true,
                         admin: true )
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    phone_number = "516-354-6189"
    company_id = 2
    alpine_user = false
    entitled = false
    company_admin = false
    admin = false
    User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                phone_number: phone_number,
                company_id: company_id,
                alpine_user: alpine_user,
                entitled: entitled,
                company_admin: company_admin,
                admin: admin)
  end
end