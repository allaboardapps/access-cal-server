class RegionSerializer < ActiveModel::Serializer
  attributes(
    :id,
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
