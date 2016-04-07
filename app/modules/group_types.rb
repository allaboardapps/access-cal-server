module GroupTypes
  BILLING = "billing".freeze
  EDITORS = "editors".freeze
  MANAGERS = "managers".freeze
  OWNERS = "owners".freeze
  VIEWERS = "viewers".freeze

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
