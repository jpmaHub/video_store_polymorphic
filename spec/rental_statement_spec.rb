# frozen_string_literal: true

require 'rental_statement'

describe RentalStatement do
  context 'Regular movie rental' do
    let(:rental_statement) { RentalStatement.new }
    it 'returns statement' do
      expect(rental_statement.statement('john', 2, 5.5, [['wood', 2.0], ['polo', 3.5]])).to eq("Rental Record for john
    [[\"wood\", 2.0], [\"polo\", 3.5]]\n    You earned 2 frequent renter points\n    You owe 5.5")
    end
  end
end
