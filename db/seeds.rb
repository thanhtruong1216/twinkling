puts '--> Seeding users, polls, options, votes with 20+ votes per poll...'

# Xoá dữ liệu cũ
Vote.destroy_all
Option.destroy_all
Poll.destroy_all
User.destroy_all

image_file_path = Rails.root.join('app', 'assets', 'images', 'slide-image_9.jpeg')

# Danh sách quốc gia mẫu
COUNTRIES = [
  "Vietnam", "United States", "Japan", "France", "Germany",
  "Canada", "Australia", "India", "Brazil", "United Kingdom"
]

# Tạo main user
main_user = User.create!(
  email: "thanhtruong1216@gmail.com",
  user_name: "Julia",
  full_name: "Julia Robert",
  password: "123456",
  password_confirmation: "123456"
)
# main_user.avatar.attach(io: File.open(image_file_path), filename: "avatar_main.jpg") if File.exist?(image_file_path)

# Tạo thêm 25 user khác (đảm bảo đủ votes)
25.times do
  user = User.new(
    email: Faker::Internet.unique.email,
    user_name: Faker::Artist.unique.name,
    full_name: Faker::Name.name,
    password: "opensesame",
    password_confirmation: "opensesame"
  )
  # user.avatar.attach(io: File.open(image_file_path), filename: "avatar.jpg") if File.exist?(image_file_path)
  user.save!
end

users = User.where.not(id: main_user.id)
vote_comment_texts = [
  "I totally agree!",
  "Not sure about this...",
  "Interesting choice.",
  "Could be better.",
  "Love it!",
  "This is tricky."
]

20.times do
  creator = users.sample
  poll = Poll.create!(
    title: Faker::Quote.famous_last_words,
    description: Faker::Movies::StarWars.quote,
    purpose: Faker::TvShows::GameOfThrones.quote,
    user: creator,
    status: 'approved',
    visible: true
  )
  poll.image.attach(io: File.open(image_file_path), filename: "poll_image.jpg") if File.exist?(image_file_path)

  # Tạo 3 options cho mỗi poll
  options = 3.times.map do
    option_text = Faker::Books::Dune.quote.split(".").first.strip
    option = poll.options.create!(text: option_text)
    option.image.attach(io: File.open(image_file_path), filename: "option_image.jpg") if File.exist?(image_file_path)
    option
  end

  # Chọn 20 user khác creator để vote
  voters = users.where.not(id: creator.id).to_a.shuffle.first(20)

  voters.each do |voter|
    chosen_option = options.sample
    country = COUNTRIES.sample
    ip_address = Faker::Internet.public_ip_v4_address

    chosen_option.votes.create!(
      user: voter,
      ip_address: ip_address,
      country: country,
      comment: vote_comment_texts.sample
    )
  end
end

puts '--> Seeding complete: 20 polls, 3 options each, 20 votes per poll, with comments!'
