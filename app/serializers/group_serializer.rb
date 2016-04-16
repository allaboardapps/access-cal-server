class GroupSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :organization_id,
    :group_type,
    :archived,
    :test,
    :dummy,
    :created_at,
    :updated_at
  )
end
