# frozen_string_literal: true

require 'children_movie'

describe ChildrenMovie do
  it 'returns total and points for the rented movie' do
    children_movie = described_class.new(days_rented: 2)
    expect(children_movie.determine_amount).to eq(1.5)
    expect(children_movie.determine_frequent_renter_points).to eq(1)
  end
end
