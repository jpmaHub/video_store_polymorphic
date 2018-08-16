require 'movie_rental'
require 'movie'
require 'children_movie'
require 'rental_statement'
require 'new_release_movie'
require 'regular_movie'
require 'customer_record'

def customer_record(movies_list, name)
  CustomerRecord.new(movies_list: movies_list, cust_name: name)
end 

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

describe RegularMovie do
  it 'returns amount and point for the regular rented movie' do
    regular_movie = described_class.new(days_rented: 3)
    expect(regular_movie.determine_amount).to eq(3.5)
    expect(regular_movie.determine_frequent_renter_points).to eq(1)
  end
end

describe ChildrenMovie do
  it 'returns total and points for the rented movie' do
    children_movie = described_class.new(days_rented: 2)
    expect(children_movie.determine_amount).to eq(1.5)
    expect(children_movie.determine_frequent_renter_points).to eq(1)
  end
end

describe NewReleaseMovie do
  it 'returns amount and point for the newly released rented movie' do
    new_release_movie = described_class.new(days_rented: 3)
    expect(new_release_movie.determine_amount).to eq(9)
    expect(new_release_movie.determine_frequent_renter_points).to eq(2)
  end
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

describe RentalStatement do
  context 'Regular movie rental' do
    let(:rental_statement) { RentalStatement.new }
    it 'returns statement' do
      expect(rental_statement.statement('john', 2, 5.5, [['wood', 2.0], ['polo', 3.5]])).to eq("Rental Record for john
    [[\"wood\", 2.0], [\"polo\", 3.5]]\n    You earned 2 frequent renter points\n    You owe 5.5")
    end
  end
end

describe CustomerRecord do
  let(:rental_statment) { RentalStatement.new }

  it 'return movies when string passed' do
    wood_movie = movie_name('wood')
    polo_movie = movie_name('polo')

    regular_movie_spy = double('RegularMovie', days_rented: 3)
    
    days_rented_wood = 3
    days_rented_pool = 2


    regular_rental_wood = rental(regular_movie(2))
    regular_rental_polo = rental(regular_movie(3))

    movies_list = [polo_movie.name, wood_movie.name]
    cust_record = customer_record(movies_list, 'mark')

    rental_points = regular_rental_wood.determine_frequent_renter_points, regular_rental_polo.determine_frequent_renter_points
    amount_with_list = regular_rental_wood.determine_amount, regular_rental_polo.determine_amount
    rental_total = regular_rental_wood.determine_amount, regular_rental_polo.determine_amount

    points = cust_record.return_points(*rental_points)
    movies_list = cust_record.movies_list([*amount_with_list])
    total = cust_record.return_total(*rental_total)

    rental_execute = rental_statment.statement(cust_record.name, points, total, movies_list)
    expect(rental_execute).to eq("Rental Record for mark
    polo 2.0\nwood 3.5
    You earned 2 frequent renter points
    You owe 5.5")
  end
end