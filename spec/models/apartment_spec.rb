require 'rails_helper'

RSpec.describe Apartment, type: :model do
  describe '#next_available_date' do
    let(:apartment) { Apartment.create!(name: 'Apto Teste', price: 300, location: 'Centro') }

    before do
      Booking.create!(
        accommodation: apartment,
        start_date: Date.today + 1,
        end_date: Date.today + 3,
        guest_name: 'Ana'
      )
      Booking.create!(
        accommodation: apartment,
        start_date: Date.today + 4,
        end_date: Date.today + 5,
        guest_name: 'Bruno'
      )
    end

    it 'returns the next available date after existing bookings' do
      result = apartment.next_available_date(Date.today + 1)
      expect(result).to eq(Date.today + 6)
    end

    it 'returns today if no bookings exist' do
      apartment.bookings.destroy_all
      expect(apartment.next_available_date).to eq(Date.today)
    end
  end
end
