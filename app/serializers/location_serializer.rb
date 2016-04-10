class LocationSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :region_id,
    :name,
    :abbreviation,
    :time_zone,
    :archived,
    :test,
    :dummy,
    :created_at,
    :updated_at
  )
end
