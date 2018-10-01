#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
puts "Would you like information on a character or movie?"
input = gets.chomp
if input.downcase == "character"
  puts "Which character?"
  character = get_character_from_user
  show_character_movies(character)
elsif input.downcase == "movie"
  puts "What movie?"
  movie = get_movie_from_user
  show_movie_info(movie)
else
  "please enter a valid input next time"
end
