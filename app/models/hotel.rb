class Hotel < Accommodation
  def next_available_date(from_date = nil)
    from_date ||= Date.today
    from_date
  end
end
