spawn do
  sleep 3.seconds
  puts "Hello from fiber 1!"
  puts Time.utc
end

spawn do
  sleep 6.seconds
  puts "Hello from fiber 2!"
  puts Time.utc
end

puts Time.utc
puts "Hello from the main fiber."
sleep 10.seconds
puts "We're back in the main fiber."
puts Time.utc

# puts "Hello world!"