puts "--> Updating poll descriptions to match one of the options..."

Poll.all.each do |poll|
  # Lấy danh sách text các option
  option_texts = poll.options.pluck(:text)

  # Chọn ngẫu nhiên một option để làm description
  new_description = option_texts.sample

  poll.update!(description: new_description)
  puts "Updated poll ##{poll.id} (#{poll.title}) description to: #{new_description}"
end

puts "--> Done updating poll descriptions!"
