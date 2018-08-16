# frozen_string_literal: true

require 'regular_movie'

describe RegularMovie do
  it 'returns amount and point for the regular rented movie' do
    regular_movie = described_class.new(days_rented: 3)
    expect(regular_movie.determine_amount).to eq(3.5)
    expect(regular_movie.determine_frequent_renter_points).to eq(1)
  end
end
