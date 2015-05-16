class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :first_name,
    :last_name,
    :roles,
    :archived,
    :test,
    :token,
    :updated_at,
    :created_at
  )
end
