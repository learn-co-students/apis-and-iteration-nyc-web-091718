def welcome
  puts "Hello, inquiring friend. Welcome to the Force!!"
  # puts out a welcome message here!
end

def get_character_from_user
  puts "Please enter a character:"
  character_input = gets.strip.downcase
  character_input
  # use gets to capture the user's input.
  # This method should return that input, downcased.
end
