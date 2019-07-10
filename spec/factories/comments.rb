FactoryBot.define do
  factory :comment do
    user
    post
    content { Faker::Quotes::Shakespeare.romeo_and_juliet_quote }
  end
end
