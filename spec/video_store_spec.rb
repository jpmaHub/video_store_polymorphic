require 'movie_rental'
require 'movie'
require 'children_movie'
require 'rental_statement'
require 'new_release_movie'
require 'regular_movie'
require 'customer_record'
require 'video_store'

def customer_record(movies_list, name)
  CustomerRecord.new(movies_list: movies_list, cust_name: name)
end 

def movie_rental(type , days)
  MovieRental.new(rental_type: create_rental_for(type, days))
end

def create_rental_for(type, days)
  VideoStoreFactory.new.create(type, days)
end 

def create_movie(name)
  VideoStoreFactory.new.create_movie(name)
end 

describe VideoStoreFactory do
  let(:rental_statment) { RentalStatement.new }
  it 'returns amount and point for the regular rented movie' do
    regular = movie_rental(:regular, 3)
    expect(regular.determine_amount).to eq(3.5)
    expect(regular.determine_frequent_renter_points).to eq(1)
  end 

  it 'returns total and points for the children movie rented movie' do
    children = movie_rental(:children, 3)
    expect(children.determine_amount).to eq(1.5)
    expect(children.determine_frequent_renter_points).to eq(1)
  end

  it 'returns amount and point for the newly released rented movie' do
    new_release = movie_rental(:new_release, 3)
    expect(new_release.determine_amount).to eq(9)
    expect(new_release.determine_frequent_renter_points).to eq(2)
  end

  it 'return movies when string passed' do
    wood_movie = create_movie('wood')
    polo_movie = create_movie('polo')

    regular_wood = movie_rental(:regular, 2)
    regular_polo = movie_rental(:regular, 3)

    movies_list = [polo_movie.name, wood_movie.name]
    cust_record = customer_record(movies_list, 'mark')

    rental_points =  regular_wood.determine_frequent_renter_points, regular_polo.determine_frequent_renter_points
    amount_with_list =  regular_wood.determine_amount, regular_polo.determine_amount
    rental_total =  regular_wood.determine_amount, regular_polo.determine_amount

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