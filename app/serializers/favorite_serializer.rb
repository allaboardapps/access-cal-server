class FavoriteSerializer < ActiveModel::Serializer
  attributes(
    :user_id,
    :event_id,
    :archived,
    :test,
    :created_at,
    :updated_at
  )
end
