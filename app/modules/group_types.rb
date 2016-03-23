module GroupTypes
  BILLING = "billing"
  EDITORS = "editors"
  MANAGERS = "managers"
  OWNERS = "owners"
  VIEWERS = "viewers"

  def self.all
    [
      GroupTypes::OWNERS,
      GroupTypes::BILLING,
      GroupTypes::MANAGERS,
      GroupTypes::EDITORS,
      GroupTypes::VIEWERS
    ]
  end
end
