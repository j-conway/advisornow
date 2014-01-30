namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_consults
    make_consult_memberships
    make_companies
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
  45.times do |n|
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

  44.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+46}@railstutorial.org"
    password  = "password"
    phone_number = "516-354-6189"
    company_id = 3
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

def make_consults
  50.times do |n|
    creator_id = "#{n+1}"
    customer_id = "#{n+2}"
    datascientist_id = "#{n+3}"
    subject = Faker::Lorem.sentence(5)
    Consult.create!(creator_id: creator_id,
                customer_id: customer_id,
                datascientist_id: datascientist_id,
                subject: subject)
  end
end

def make_consult_memberships
  25.times do |n|
    10.times do |m|
      user_id = "#{100-m-n}"
      consult_id = "#{n+1}"
      ConsultMembership.create!(user_id: user_id,
                consult_id: consult_id)
    end
  end
  25.times do |n|
    10.times do |m|
      user_id = "#{m+n+1}"
      consult_id = "#{n+1}"
      ConsultMembership.create!(user_id: user_id,
                consult_id: consult_id)
    end
  end
end

def make_companies
  3.times do |n|
    name = Faker::Lorem.sentence(rand(2)).chomp('.')
    entitlements  = 5
    Company.create!(name: name,
                     entitlements: entitlements)
  end
end