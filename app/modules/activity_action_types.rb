module ActivityActionTypes
  CREATE = "create"
  UPDATE = "update"
  DELETE = "delete"
  ARCHIVE = "archive"
  UNARCHIVE = "unarchive"

  def self.all
    [
      ActivityActionTypes::CREATE,
      ActivityActionTypes::UPDATE,
      ActivityActionTypes::DELETE,
      ActivityActionTypes::ARCHIVE,
      ActivityActionTypes::UNARCHIVE
    ]
  end
end
