# frozen_string_literal: true

require 'customer_record'

def rental(rental_type)
  MovieRental.new(rental_type: rental_type)
end

def customer_record(movies_list, name)
  CustomerRecord.new(movies_list: movies_list, cust_name: name)
end 

def regular_movie(days)
  RegularMovie.new(days_rented: days)
end 

describe CustomerRecord do
  let(:rental_statment) { RentalStatement.new }

  it 'return movies when string passed' do
    wood_movie = movie_name('wood')
    polo_movie = movie_name('polo')

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
