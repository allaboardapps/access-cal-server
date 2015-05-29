class UserSerializer < ActiveModel::Serializer
  attributes(
    :token,
    :id,
    :first_name,
    :last_name,
    :email,
    :zip_code,
    :time_zone,
    :location_id,
    :roles,
    :statuses,
    :archived,
    :test,
    :updated_at,
    :created_at
  )
end
