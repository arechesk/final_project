puts "Creating vip tickets for 09.07.2024"
50.times do |i|
  Ticket.create!(date: "09.07.2024", status: "available", category: "vip")
  print '.'
  STDOUT.flush
end

puts "Creating regular tickets for 09.07.2024"
150.times do |i|
  Ticket.create!(date: "09.07.2024", status: "available", category: "regular")
  print '.'
  STDOUT.flush
end
