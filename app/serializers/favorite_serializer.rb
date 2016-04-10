class FavoriteSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :user_id,
    :event_id,
    :archived,
    :test,
    :dummy,
    :created_at,
    :updated_at
  )
end
