class RegionSerializer < ActiveModel::Serializer
  attributes(
    :name,
    :abbreviation,
    :time_zone,
    :archived,
    :test,
    :created_at,
    :updated_at
  )
end
