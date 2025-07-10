class Booking < ApplicationRecord
  belongs_to :accommodation

  validates :guest_name, presence: true, length: { minimum: 2 }
  validates :accommodation_id, presence: true
  validate :no_overlap_for_apartments

  private

  def no_overlap_for_apartments
    return unless accommodation.is_a?(Apartment)

    overlapping = Booking.where(accommodation_id: accommodation_id)
                         .where.not(id: id)
                         .where("start_date <= ? AND end_date >= ?", end_date, start_date)

    if overlapping.exists?
      errors.add(:base, "Apartments cannot have overlapping bookings")
    end
  end
end
