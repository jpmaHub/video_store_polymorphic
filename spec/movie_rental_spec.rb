# frozen_string_literal: true

require 'movie_rental'
require 'movie'

def movie_name(name)
  Movie.new(movie_name: name)
end

def new_release_movie(days)
  NewReleaseMovie.new(days_rented: days)
end

def children_movie(days)
  ChildrenMovie.new(days_rented: days)
end

def regular_movie(days)
  RegularMovie.new(days_rented: days)
end 

def rental(rental_type)
  MovieRental.new(rental_type: rental_type)
end

describe MovieRental do
  context 'Regular movie rental' do
    it 'return 0 when nil passed' do
      movie = movie_name(nil)
      movie_rental = rental(regular_movie(0))
      expect(movie.name).to eq('No Movie')
      expect(movie_rental.determine_amount).to eq(0)
      expect(movie_rental.determine_frequent_renter_points).to eq(0)
    end

    it 'return the amount and point when string passed' do
      movie = movie_name('teeth')
      movie_rental = rental(regular_movie(2))
      expect(movie.name).to eq('teeth')
      expect(movie_rental.determine_amount).to eq(2.0)
      expect(movie_rental.determine_frequent_renter_points).to eq(1)
    end
  end

  context 'New Release movie rental' do
    it 'return 0 when nil passed' do
      movie = movie_name(nil)
      movie_rental = rental(new_release_movie(0))
      expect(movie.name).to eq('No Movie')
      expect(movie_rental.determine_amount).to eq(0)
      expect(movie_rental.determine_frequent_renter_points).to eq(0)
    end

    it 'return the amount and point when string passed' do
      movie = movie_name('casper')
      movie_rental = rental(new_release_movie(4))
      expect(movie.name).to eq('casper')
      expect(movie_rental.determine_amount).to eq(12.0)
      expect(movie_rental.determine_frequent_renter_points).to eq(2)
    end
  end

  context 'Children movie rental' do
    it 'return 0 when nil passed' do
      movie = movie_name(nil)
      movie_rental = rental(children_movie(0))
      expect(movie.name).to eq('No Movie')
      expect(movie_rental.determine_amount).to eq(0)
      expect(movie_rental.determine_frequent_renter_points).to eq(0)
    end

    it 'return the amount and point when string passed' do
      movie = movie_name('Superman')
      movie_rental = rental(children_movie(4))
      expect(movie.name).to eq('Superman')
      expect(movie_rental.determine_amount).to eq(3.0)
      expect(movie_rental.determine_frequent_renter_points).to eq(1)
    end
  end
end
