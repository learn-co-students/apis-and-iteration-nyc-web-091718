require 'rest-client'
require 'json'
require 'pry'

def parser(element)
  JSON.parse(RestClient.get(element))
end

# def films_url(response_hash)
#   films = []
#   response_hash["results"].each {|e|
#     if e["name"].downcase == character.downcase
#       films = e["films"]
#       # binding.pry
#     end
#   }
# end

def full_array
  full_array = []
  i = 1
  # url = "http://www.swapi.co/api/people/?page=#{i}"
  loop do
    full_array << parser("http://www.swapi.co/api/people/?page=#{i}")
    i += 1
    if parser("http://www.swapi.co/api/people/?page=#{i}")["next"] == nil
      full_array << parser("http://www.swapi.co/api/people/?page=#{i}")
      break
    end
  end
  full_array
  # binding.pry
end


def get_character_movies_from_api(character)
  #make the web request
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)

  # response_hash = parser('http://www.swapi.co/api/people/?page=1')
  # binding.pry
  # i = 1
  # while response_hash["next"] != nil
  # response_hash["name"].downcase == character.downcase
  # binding.pry
  films = []

  full_array.each {|page| page["results"].each {|e|
    if e["name"].downcase == character.downcase
      films = e["films"]
      # binding.pry
    end
  }}

  # films.each {|film| }
  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.


  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  films_hash = films.map {|url| parser(url)}
  # binding.pry
end
# get_character_movies_from_api('Luke Skywalker')
def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  # get_character_movies_from_api
  film_list = films_hash.map {|film| film["title"]
  # binding.pry
    }
  list = film_list.join(', ')
  puts list
  # binding.pry
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
