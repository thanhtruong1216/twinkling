puts '--> Seeding users, polls, options, votes with single image and distributed votes...'

Vote.destroy_all
Option.destroy_all
Poll.destroy_all
User.destroy_all

image_file_path = Rails.root.join('app', 'assets', 'images', 'slide-image_9.jpeg')

main_user = User.create!(
  email: "thanhtruong1216@gmail.com",
  user_name: "Julia",
  full_name: "Julia Robert",
  password: "123456",
  password_confirmation: "123456"
)
main_user.avatar.attach(io: File.open(image_file_path), filename: "avatar_main.jpg") if File.exist?(image_file_path)

5.times do
  email = Faker::Internet.email
  user_name = Faker::Artist.name
  full_name = Faker::Name.name
  password = "opensesame"

  user = User.new(
    email: email,
    user_name: user_name,
    full_name: full_name,
    password: password,
    password_confirmation: password
  )
  user.avatar.attach(io: File.open(image_file_path), filename: "avatar.jpg") if File.exist?(image_file_path)
  user.save!
end

puts '--> Creating polls, options, and distributed votes...'

User.find_each do |user|
  2.times do
    poll = Poll.create!(
      title: Faker::Quote.famous_last_words,
      description: Faker::Movies::StarWars.quote,
      purpose: Faker::TvShows::GameOfThrones.quote,
      user: user
    )

    poll.image.attach(io: File.open(image_file_path), filename: "poll_image.jpg") if File.exist?(image_file_path)

    options = []
    3.times do
      option_text = Faker::Books::Dune.quote.split(".").first.strip
      option = poll.options.create!(text: option_text)
      option.image.attach(io: File.open(image_file_path), filename: "option_image.jpg") if File.exist?(image_file_path)
      options << option
    end

    voters = User.where.not(id: user.id).to_a.shuffle
    voters.each do |voter|
      chosen_option = options.sample
      chosen_option.votes.create!(user: voter)
    end
  end
end

puts '--> Seed complete with distributed votes and single image for all attachments!'
