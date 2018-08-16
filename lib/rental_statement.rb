# frozen_string_literal: true

class RentalStatement
  def rental
    { statement: statement }
  end

  def statement(name, points, total, movies_list)
    "#{customer_name(name)}
    #{movies_list(movies_list)}
    #{renter_points(points)}
    #{total(total)}"
  end

  def customer_name(name)
    "Rental Record for #{name}"
  end

  def renter_points(points)
    "You earned #{points} frequent renter points"
  end

  def total(total)
    "You owe #{total}"
  end

  def movies_list(movies_list)
    movies_list.to_s
  end
end
