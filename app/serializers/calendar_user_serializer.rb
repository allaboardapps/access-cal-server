class CalendarUserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :user_id,
    :calendar_id,
    :role
  )
end
