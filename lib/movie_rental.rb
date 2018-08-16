# frozen_string_literal: true

class MovieRental
  def initialize(rental_type:)
    @rental_type = rental_type
  end

  def determine_amount
    @rental_type.determine_amount
  end

  def determine_frequent_renter_points
    @rental_type.determine_frequent_renter_points
  end
end
