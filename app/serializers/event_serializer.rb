class EventSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :location_id,
    :name,
    :abbreviation,
    :description,
    :street_address,
    :secondary_address,
    :city,
    :state,
    :country,
    :zip_code,
    :time_zone,
    :latitude,
    :longitude,
    :starts_at,
    :ends_at,
    :archived,
    :test,
    :dummy,
    :created_at,
    :updated_at
  )
end
