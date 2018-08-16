# frozen_string_literal: true

class Movie
  def initialize(movie_name:)
    @movie_name = movie_name
  end

  def name
    return 'No Movie' if @movie_name.nil?
    @movie_name
  end
end
