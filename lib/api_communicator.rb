require 'rest-client'
require 'json'
require 'pry'

# def get_character_movies_from_api(character)
#   response_string = RestClient.get('http://www.swapi.co/api/people/')
#   response_hash = JSON.parse(response_string)
#   while response_hash
#     character_urls = response_hash["results"].find do |char|
#       if char["name"].downcase == character.downcase
#         return char
#       end
#     end
#       response_hash = JSON.parse(response_hash["next"])
#   end
# end


def get_character_movies_from_api(character)
  all_chars = RestClient.get('http://www.swapi.co/api/people/')
  char_hash = JSON.parse(all_chars)
  while char_hash
    urls = char_hash['results'].find { |hash| hash['name'].downcase == character}
    if urls
      return urls['films'].map {|film| JSON.parse(RestClient.get(film))}
    end
    char_hash = char_hash['next'] ?
    JSON.parse(RestClient.get(char_hash['next'])) : nil
  end
end


def print_movies(films_array)
  #binding.pry
  titles = films_array.map do |film|
      film["title"]
    end
  puts titles
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS



# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
