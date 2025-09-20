puts "--> Updating poll purposes..."

# Tạo một hash mapping: {poll_title => new_purpose}
new_purposes = {
  "Bạn sẽ chọn làm gì để giảm căng thẳng sau một ngày dài?" =>
    "Khám phá cách mọi người thư giãn và duy trì tinh thần tích cực.",
  "Nếu có cơ hội sống ở một nơi mới trong 1 năm, bạn chọn ở đâu?" =>
    "Hiểu mong muốn trải nghiệm và khám phá thế giới của mọi người.",
  "Điều gì làm bạn cảm thấy hạnh phúc nhất?" =>
    "Tìm hiểu điều gì thực sự quan trọng và mang lại hạnh phúc.",
  "Bạn muốn tương lai công nghệ phát triển theo hướng nào?" =>
    "Khám phá xu hướng công nghệ mà mọi người quan tâm nhất.",
  "Khi mệt mỏi, bạn thường tìm đến điều gì?" =>
    "Hiểu cách mọi người chăm sóc bản thân khi căng thẳng.",
  "Món ăn Việt Nam nào bạn thấy đáng tự hào nhất?" =>
    "Khám phá những món ăn mang lại niềm tự hào văn hóa.",
  "Bạn muốn dành kỳ nghỉ lý tưởng ở đâu?" =>
    "Hiểu sở thích và phong cách nghỉ dưỡng của mọi người.",
  "Thói quen nào giúp bạn làm việc hiệu quả hơn?" =>
    "Tìm hiểu những bí quyết duy trì hiệu suất cao.",
  "Khi gặp khó khăn, bạn thường tìm đến ai?" =>
    "Hiểu vai trò các mối quan hệ trong việc vượt qua thử thách.",
  "Bạn muốn thay đổi điều gì nhất trong cuộc sống hiện tại?" =>
    "Khám phá những khía cạnh cuộc sống mà mọi người muốn cải thiện.",

  # Polls tiếng Anh
  "What motivates you the most in life?" =>
    "Understand the driving forces behind people's actions and decisions.",
  "If you could instantly learn a new skill, what would it be?" =>
    "Discover the skills people most want to acquire and why.",
  "Which future innovation excites you most?" =>
    "Learn which innovations inspire hope and curiosity.",
  "What is the best way to spend a weekend?" =>
    "Explore how people like to relax and recharge.",
  "What do you value most in a friendship?" =>
    "Understand the key aspects people cherish in friendships.",
  "Which book genre inspires you the most?" =>
    "Find out what type of books motivates and influences people.",
  "What would you choose if money wasn’t an issue?" =>
    "Discover what people truly desire when resources aren’t a limitation.",
  "What’s the biggest lesson you learned this year?" =>
    "Reflect on the insights and experiences that shaped people.",
  "If you could relive one moment in life, what would it be?" =>
    "Learn which moments in life people hold most dear.",
  "How do you define success?" =>
    "Explore how people perceive success in life."
}

# Loop qua hash để cập nhật purpose
new_purposes.each do |title, purpose|
  poll = Poll.find_by(title: title)
  if poll
    poll.update!(purpose: purpose)
    puts "Updated purpose for: #{title}"
  else
    puts "Poll not found: #{title}"
  end
end

puts "--> Done updating poll purposes!"
