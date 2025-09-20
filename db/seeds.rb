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

# Main user
main_user = User.create!(
  email: "thanhtruong1216@gmail.com",
  user_name: "Julia",
  full_name: "Julia Robert",
  password: "123456",
  password_confirmation: "123456"
)
main_user.avatar.attach(io: File.open(image_file_path), filename: "avatar_main.jpg") if File.exist?(image_file_path)

# Tạo thêm 25 user khác
25.times do
  user = User.new(
    email: Faker::Internet.unique.email,
    user_name: Faker::Internet.unique.username(specifier: 5..10),
    full_name: Faker::Name.name,
    password: "opensesame",
    password_confirmation: "opensesame"
  )
  user.avatar.attach(io: File.open(image_file_path), filename: "avatar.jpg") if File.exist?(image_file_path)
  user.save!
end

users = User.where.not(id: main_user.id)

# Poll tiếng Việt
polls_vi = [
  {
    title: "Bạn sẽ chọn làm gì để giảm căng thẳng sau một ngày dài?",
    description: "Ai cũng có cách riêng để thư giãn. Bạn thì sao?",
    options: ["Nghe nhạc", "Tập thể dục", "Đi chơi với bạn bè"]
  },
  {
    title: "Nếu có cơ hội sống ở một nơi mới trong 1 năm, bạn chọn ở đâu?",
    description: "Thay đổi môi trường có thể mở ra góc nhìn mới.",
    options: ["Một thành phố lớn", "Một vùng quê yên bình", "Một đất nước khác"]
  },
  {
    title: "Điều gì làm bạn cảm thấy hạnh phúc nhất?",
    description: "Một câu hỏi đơn giản nhưng câu trả lời có thể rất sâu sắc.",
    options: ["Gia đình", "Sự nghiệp", "Tự do cá nhân"]
  },
  {
    title: "Bạn muốn tương lai công nghệ phát triển theo hướng nào?",
    description: "Công nghệ ảnh hưởng đến tất cả chúng ta.",
    options: ["AI thông minh hơn", "Năng lượng sạch", "Du hành vũ trụ"]
  },
  {
    title: "Khi mệt mỏi, bạn thường tìm đến điều gì?",
    description: "Chia sẻ để mọi người có thể học cách chăm sóc bản thân.",
    options: ["Ăn uống ngon", "Ngủ thật sâu", "Tâm sự với người thân"]
  },
  {
    title: "Món ăn Việt Nam nào bạn thấy đáng tự hào nhất?",
    description: "Ẩm thực Việt Nam rất đa dạng, bạn sẽ chọn món nào?",
    options: ["Phở", "Bánh mì", "Bún chả"]
  },
  {
    title: "Bạn muốn dành kỳ nghỉ lý tưởng ở đâu?",
    description: "Biển xanh, núi cao hay một thành phố sôi động?",
    options: ["Biển", "Núi", "Thành phố lớn"]
  },
  {
    title: "Thói quen nào giúp bạn làm việc hiệu quả hơn?",
    description: "Hãy chia sẻ bí quyết để giữ sự tập trung.",
    options: ["Viết to-do list", "Pomodoro", "Nghe nhạc tập trung"]
  },
  {
    title: "Khi gặp khó khăn, bạn thường tìm đến ai?",
    description: "Một chút suy ngẫm về mối quan hệ xung quanh.",
    options: ["Gia đình", "Bạn bè", "Chính bản thân mình"]
  },
  {
    title: "Bạn muốn thay đổi điều gì nhất trong cuộc sống hiện tại?",
    description: "Một câu hỏi để nhìn lại bản thân.",
    options: ["Thời gian cho bản thân", "Công việc", "Các mối quan hệ"]
  }
]

# Poll tiếng Anh
polls_en = [
  {
    title: "What motivates you the most in life?",
    description: "A simple question, but the answers can be deep.",
    options: ["Family", "Passion", "Freedom"]
  },
  {
    title: "If you could instantly learn a new skill, what would it be?",
    description: "Skills shape who we are and what we can do.",
    options: ["Play an instrument", "Code like a pro", "Speak another language"]
  },
  {
    title: "Which future innovation excites you most?",
    description: "Technology is changing fast, what do you hope for?",
    options: ["Artificial Intelligence", "Space Travel", "Green Energy"]
  },
  {
    title: "What is the best way to spend a weekend?",
    description: "Different people, different lifestyles.",
    options: ["Relaxing at home", "Exploring nature", "Hanging out with friends"]
  },
  {
    title: "What do you value most in a friendship?",
    description: "Trust, fun, or growth?",
    options: ["Loyalty", "Shared laughter", "Personal growth"]
  },
  {
    title: "Which book genre inspires you the most?",
    description: "Books can shape our thoughts.",
    options: ["Fiction", "Non-fiction", "Self-help"]
  },
  {
    title: "What would you choose if money wasn’t an issue?",
    description: "Sometimes, freedom of choice reveals our true selves.",
    options: ["Travel the world", "Start a business", "Focus on hobbies"]
  },
  {
    title: "What’s the biggest lesson you learned this year?",
    description: "Sharing experiences helps others grow too.",
    options: ["Patience", "Consistency", "Letting go"]
  },
  {
    title: "If you could relive one moment in life, what would it be?",
    description: "Memories define us.",
    options: ["Childhood", "A big success", "A moment with loved ones"]
  },
  {
    title: "How do you define success?",
    description: "Everyone has their own definition.",
    options: ["Happiness", "Wealth", "Impact on others"]
  }
]

# Comments mẫu (Việt + Anh)
vote_comments = [
  # Vietnamese
  "Mình thấy lựa chọn này rất hợp lý.",
  "Không đồng ý lắm, nhưng cũng đáng để suy nghĩ.",
  "Mình từng thử và thấy khá hiệu quả.",
  "Câu hỏi này làm mình suy ngẫm rất nhiều.",
  "Thật sự lựa chọn này sẽ tạo ra nhiều thay đổi tích cực.",
  "Khá thú vị, mình chưa từng nghĩ tới trước đây.",
  "Nghe có vẻ đơn giản, nhưng ý nghĩa sâu xa lắm.",
  "Mình nghĩ ai cũng sẽ chọn như vậy thôi.",
  # English
  "I think this is a very practical choice.",
  "Not sure if I agree, but it makes sense.",
  "I tried this once and it worked for me.",
  "This question really makes me reflect.",
  "Honestly, this choice could change a lot.",
  "Interesting perspective, never thought about it that way.",
  "Sounds simple but has a deeper meaning.",
  "I believe most people would pick this as well."
]

# Gộp poll tiếng Việt + tiếng Anh
all_polls = polls_vi + polls_en

all_polls.each do |poll_data|
  creator = users.sample
  poll = Poll.create!(
    title: poll_data[:title],
    description: poll_data[:description],
    purpose: Faker::Quote.matz,
    user: creator,
    status: 'approved',
    visible: true
  )
  poll.image.attach(io: File.open(image_file_path), filename: "poll_image.jpg") if File.exist?(image_file_path)

  # Options
  options = poll_data[:options].map do |opt_text|
    option = poll.options.create!(text: opt_text)
    option.image.attach(io: File.open(image_file_path), filename: "option_image.jpg") if File.exist?(image_file_path)
    option
  end

  # Votes (20 per poll)
  voters = users.where.not(id: creator.id).to_a.shuffle.first(20)
  voters.each do |voter|
    chosen_option = options.sample
    country = COUNTRIES.sample
    ip_address = Faker::Internet.public_ip_v4_address

    chosen_option.votes.create!(
      user: voter,
      ip_address: ip_address,
      country: country,
      comment: vote_comments.sample
    )
  end
end

puts '--> Seeding complete: 20 polls (10 Vietnamese + 10 English), 3 options each, 20 votes per poll!'
