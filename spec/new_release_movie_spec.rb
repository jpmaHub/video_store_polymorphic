# frozen_string_literal: true

require 'new_release_movie'

describe NewReleaseMovie do
  it 'returns amount and point for the newly released rented movie' do
    new_release_movie = described_class.new(days_rented: 3)
    expect(new_release_movie.determine_amount).to eq(9)
    expect(new_release_movie.determine_frequent_renter_points).to eq(2)
  end
end
