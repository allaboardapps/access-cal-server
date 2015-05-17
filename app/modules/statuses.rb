module Statuses
  BASIC = "basic"
  PRO = "pro"
  PREMIUM = "premium"

  def self.all
    [Statuses::BASIC, Statuses::PRO, Statuses::PREMIUM]
  end
end
