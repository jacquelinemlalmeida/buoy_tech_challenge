puts "Seeding data..."

3.times do |i|
  Hotel.create!(
    name: "Hotel #{i + 1}",
    description: "Hotel número #{i + 1} com ótima localização",
    price: 150.00 + i * 20,
    location: "Região #{i + 1}"
  )
end

3.times do |i|
  Apartment.create!(
    name: "Apartamento #{i + 1}",
    description: "Apartamento confortável #{i + 1}",
    price: 250.00 + i * 30,
    location: "Bairro #{i + 1}"
  )
end

apartment = Apartment.first

Booking.create!(
  accommodation: apartment,
  start_date: Date.today + 2,
  end_date: Date.today + 4,
  guest_name: "João"
)

Booking.create!(
  accommodation: apartment,
  start_date: Date.today + 6,
  end_date: Date.today + 9,
  guest_name: "Maria"
)

hotel = Hotel.first

Booking.create!(
  accommodation: hotel,
  start_date: Date.today + 2,
  end_date: Date.today + 5,
  guest_name: "Carlos"
)

Booking.create!(
  accommodation: hotel,
  start_date: Date.today + 3,
  end_date: Date.today + 6,
  guest_name: "Fernanda"
)

puts "Seeding done!"
