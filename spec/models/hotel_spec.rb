require 'rails_helper'

RSpec.describe Hotel, type: :model do
  describe '#next_available_date' do
    let(:hotel) { Hotel.create!(name: 'Hotel Teste', price: 400.90, location: 'Praia') }

    it 'returns the same date given, even if bookings exist' do
      Booking.create!(
        accommodation: hotel,
        start_date: Date.today + 1,
        end_date: Date.today + 3,
        guest_name: 'Carlos'
      )

      result = hotel.next_available_date(Date.today + 1)
      expect(result).to eq(Date.today + 1)
    end

    it 'returns today if no date is provided' do
      expect(hotel.next_available_date).to eq(Date.today)
    end
  end
end
