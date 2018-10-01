#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character = get_character_from_user
does_character_exist(character)
#show_character_movies(character)
binding.pry

puts "hi"
