require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.

  found_character = get_characters.find do |person|
    person["name"].downcase == character
  end

  found_character["films"]
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def get_characters
  array_of_characters = []
  i = 1
  loop do
    response_string = RestClient.get("http://www.swapi.co/api/people/?page=#{i}")
    response_hash = JSON.parse(response_string)
    response_hash["results"].each do |person|
      array_of_characters  << person
    end
    i += 1
    if response_hash["next"] == nil
      break
    end #end of if statement
  end #end of loop do

array_of_characters
end

def get_movies_from_api(array_of_movies)
  movie_titles = array_of_movies.map do |url|
    response_string = RestClient.get(url)
    response_hash = JSON.parse(response_string)
    response_hash["title"]
  end
end

def print_movies(films_array)
  films_array.each do
    |film| puts film
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  film_title_array = get_movies_from_api(films_array)
  binding.pry
  print_movies(film_title_array)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
