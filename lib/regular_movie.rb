# frozen_string_literal: true

require 'movie_rental'
class RegularMovie < MovieRental
  def initialize(days_rented:)
    @days_rented = days_rented
  end

  def determine_amount
    amount = 2.0
    return 0 if @days_rented == 0
    return amount += cal_amount if @days_rented > 2
    amount
  end

  def cal_amount
    (@days_rented - 2) * 1.5
  end

  def determine_frequent_renter_points
    @days_rented == 0 ? 0 : 1
  end
end
