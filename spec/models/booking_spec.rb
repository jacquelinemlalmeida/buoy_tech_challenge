require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'validations' do
    let(:apartment) { Apartment.create!(name: "Apto 1", price: 200, location: "Centro") }
    let(:hotel)     { Hotel.create!(name: "Hotel 1", price: 300, location: "Orla") }

    it 'does not allow overlapping bookings for apartments' do
      Booking.create!(accommodation: apartment, start_date: Date.today, end_date: Date.today + 2, guest_name: "Alice")

      overlapping_booking = Booking.new(
        accommodation: apartment,
        start_date: Date.today + 1,
        end_date: Date.today + 3,
        guest_name: "Bob"
      )

      expect(overlapping_booking).not_to be_valid
      expect(overlapping_booking.errors[:base]).to include("Apartments cannot have overlapping bookings")
    end

    it 'allows non-overlapping bookings for apartments' do
      Booking.create!(accommodation: apartment, start_date: Date.today, end_date: Date.today + 2, guest_name: "Alice")

      valid_booking = Booking.new(
        accommodation: apartment,
        start_date: Date.today + 3,
        end_date: Date.today + 5,
        guest_name: "Carol"
      )

      expect(valid_booking).to be_valid
    end

    it 'allows overlapping bookings for hotels' do
      Booking.create!(accommodation: hotel, start_date: Date.today, end_date: Date.today + 2, guest_name: "Dan")

      overlapping = Booking.new(
        accommodation: hotel,
        start_date: Date.today + 1,
        end_date: Date.today + 3,
        guest_name: "Eve"
      )

      expect(overlapping).to be_valid
    end
  end
end
