FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    company_id "1"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :consult do
    subject "Lorem ipsum"
    datascientist_id "1"
    customer_id "1"
    creator_id "1"
  end

  factory :consult_membership do
    user
    consult
  end

end

