class OrganizationSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :archived,
    :test,
    :dummy,
    :created_at,
    :updated_at
  )
end
