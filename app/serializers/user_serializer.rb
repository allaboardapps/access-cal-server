class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :first_name,
    :last_name,
    :role,
    :archived,
    :test,
    :updated_at,
    :created_at
  )
end
