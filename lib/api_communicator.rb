require 'rest-client'
require 'json'
require 'pry'

def get_hash(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end

def get_character_movies_from_api(character)
  #make the web request
  hash = get_hash('http://www.swapi.co/api/people/')
  character_hash = hash["results"].select do |c|
    c["name"].downcase == character.downcase
  end

  films_array = character_hash[0]["films"]
  films_info = films_array.map do |film|
    get_hash(film)
  end
end

def get_movie_info_from_api(movie)
  hash = get_hash('https://swapi.co/api/films')
  film_hash = hash["results"].select do |f|
    f["title"].downcase == movie.downcase
  end[0]
end

def print_movie_info(movie)
  puts "*" * 30, "Title: #{movie["title"]}", "Episode: #{movie["episode_id"]}", "Director: #{movie["director"]}", "Release Date: #{movie["release_date"]}", "*" * 30
end

def show_movie_info(movie)
  movie_hash = get_movie_info_from_api(movie)
  print_movie_info(movie_hash)
end

def print_movies(films)
  films.each do |film|
    puts  "*" * 30, film["title"], film["release_date"]
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end
