FactoryBot.define do
  factory :user do
    email     				{ Faker::Internet.email }
    sequence(:user_name) 	{ |n| "username#{n}" }
    full_name 				{ Faker::Name.name }
    password  				{ "opensesame" }

    after(:build) do |user|
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', '1.jpg')), 
      					 filename: '1.jpeg', 
      					 content_type: 'image/jpeg')
    end
  end
end
