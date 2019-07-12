FactoryBot.define do
  factory :user do
    email     				{ Faker::Internet.email }
    sequence(:user_name) 	{ |n| "username#{n}" }
    full_name 				{ Faker::Name.name }
    password  				{ "opensesame" }
  end
end
