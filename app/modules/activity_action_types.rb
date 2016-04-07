module ActivityActionTypes
  CREATE = "create".freeze
  UPDATE = "update".freeze
  DELETE = "delete".freeze
  ARCHIVE = "archive".freeze
  UNARCHIVE = "unarchive".freeze

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
