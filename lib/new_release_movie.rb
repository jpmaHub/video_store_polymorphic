# frozen_string_literal: true

require 'movie_rental'
class NewReleaseMovie < MovieRental
  def initialize(days_rented:)
    @days_rented = days_rented
  end

  def determine_amount
    @days_rented == 0 ? 0 : 3 * @days_rented
  end

  def determine_frequent_renter_points
    return 0 if @days_rented == 0
    @days_rented < 2 ? 1 : 2
  end
end
