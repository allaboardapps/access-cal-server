class ErrorSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :status,
    :title,
    :detail
  )
end
