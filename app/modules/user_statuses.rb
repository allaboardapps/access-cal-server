module UserStatuses
  BASIC = "basic"
  NA = "not applicable"
  PRO = "pro"
  PREMIUM = "premium"

  def self.all
    [UserStatuses::BASIC, UserStatuses::NA, UserStatuses::PRO, UserStatuses::PREMIUM]
  end
end
