# frozen_string_literal: true

class CustomerRecord
  def initialize(movies_list:, cust_name:)
    @movies_list = movies_list
    @cust_name = cust_name
  end

  def name
    @cust_name
  end

  def return_total(*total)
    total.reduce(&:+)
  end

  def return_points(*points)
    points.reduce(&:+)
  end

  def movies_list(amount)
    movies_list_with_amount = []
    @movies_list.each_with_index do |movie, index|
      movies_list_with_amount.push("#{movie} #{amount[index]}")
    end
    movies_list_with_amount.join("\n")
  end
end
