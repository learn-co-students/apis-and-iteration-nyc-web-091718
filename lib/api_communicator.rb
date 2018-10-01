require 'rest-client'
require 'json'
require 'pry'

def web_request(url)
  response_string = RestClient.get(url)
  JSON.parse(response_string)
end

def get_character_movies_from_api(character)
  response_hash = web_request('http://www.swapi.co/api/people/')
  get_char_hash = response_hash['results'].select do |char_hash|
    char_hash['name'] == character
  end
  get_char_hash[0]["films"].map do |link|
    web_request(link)
  end
end

def print_movies(films_array)
  # some iteration magic and puts out the movies in a nice list
  films_array.each do |film_hash|
    puts film_hash["title"]
  end

end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
