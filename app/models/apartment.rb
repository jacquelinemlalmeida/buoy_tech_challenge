class Apartment < Accommodation

  def next_available_date(from_date = nil)
    from_date ||= Date.today
    ranges = bookings.pluck(:start_date, :end_date).sort_by(&:first)
    next_date = from_date

    loop do
      conflict = ranges.any? { |start_d, end_d| (start_d..end_d).cover?(next_date) }
      break if !conflict
      next_date += 1.day
    end

    next_date
  end

end
