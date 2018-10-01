require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.
  #binding.pry
  a = response_hash['results'].find {|char| char['name'] == character}
  #binding.pry

  # TODO Make Clearer?
  b = a['films'].map {|film| JSON.parse(RestClient.get(film))}
  b
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

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

def get_all_character_names
  #binding.pry
  char_names = []
  next_page = nil
  char_page = JSON.parse(RestClient.get('http://www.swapi.co/api/people/'))
  total_count = char_page['count']
  #binding.pry
  while char_names.flatten.size < total_count
    #binding.pry
    if char_page["next"] != nil
      #binding.pry
      a = char_page['results'].map {|c| c['name']}
      char_names << a
      char_page = get_character_page_by_url(char_page["next"])
      #binding.pry
    else
      char_names << char_page['results'].map {|c| c['name']}
      return char_names
    end
  end
  #binding.pry
  char_names
end

def get_character_page_by_url(url)
  JSON.parse(RestClient.get(url))#['results']
end

def does_character_exist(character)
  possible_names = []
  character_exists = false

  all_names = get_all_character_names.flatten
  lc_all_names = all_names.map {|n| n.downcase}
  if lc_all_names.include? character.downcase
    character_exists = true
  else
    lc_all_names.each do |n|
      if n.include? character.downcase
        possible_names << n
      end
    end
  end

  if character_exists
    puts "#{character} is in Database"
    return true
  else
    puts "Did you mean:"
    i = 0
    possible_names.each do |n|
      puts "#{i} : #{n}"
      i += 1
    end
    puts "If yes, enter appropriate number, if no enter 'n'"
    response = gets.chomp
    if response == 'n'
      return false
    else
      puts "#{possible_names[response.to_i]} is in Database"
      return true
    end
  end

  binding.pry
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
