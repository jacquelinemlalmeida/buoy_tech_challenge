class AccommodationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :location, :type, :next_available_date

  def next_available_date
    object.try(:next_available_date, Date.today)
  end
end
