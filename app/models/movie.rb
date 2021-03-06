require 'dotenv/load'
class Movie < ApplicationRecord
  Tmdb::Api.key(ENV['API_KEY'])
  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # after_initialize :get_movie_details

  def initialize(movie_id)
    super
    @api_id ||= movie_id
  end

  def self.get_genre(genre_id)
    self.genres.find { |genre|
      p genre['id']
      genre['id'] == genre_id
    }
  end

  def self.search(search_string)
    Tmdb::Search.movie(search_string).results
  end

  def self.genres
    Tmdb::Genre.movie_list
  end

  def self.get_by_genre(genre_id)
    response = Tmdb::Genre.movies(genre_id)
    response['results']
  end

  def self.get_by_id(movie_id)
      movie_details = Tmdb::Movie.detail(movie_id)
      movie_details["directors"] = Tmdb::Movie.director(movie_id)
      movie_details["cast"] = Tmdb::Movie.cast(movie_id)
      movie_details
  end
  def self.now_playing
    movies = Tmdb::Movie.now_playing
    movies.results
  end

private

  # def get_movie_details
  #   movie_details = TMDBAdapter.get_movie_details(self.api_id)
  #   if !movie_details
  #     self.destroy
  #   else
  #     self.set_attr(movie_details)
  #   end
  # end
  #
  # def set_attr(movie_details)
  #   @title = movie_details.fetch('title', nil)
  #   @release_date = movie_details.fetch('release_date', nil)
  #   @genres = movie_details.fetch('genres',[])
  #   @genre_ids = movie_details.fetch('genres', @genres.map { |genre| genre['id'] } )
  #   @revenue = movie_details.fetch('revenue', nil)
  #   @budget = movie_details.fetch('budget', nil)
  #   @overview = movie_details.fetch('overview', nil)
  #   @directors = movie_details.fetch('directors', [])
  #   @cast = movie_details.fetch('cast', [])
  # end
  #
  # def convert_collection(movies)
  #   movies.map { |movie| Movie.new(movie["id"]) }
  # end

end
