class OrganizationUserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :user_id,
    :organization_id,
    :role
  )
end
