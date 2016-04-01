module AllowedTimeZones
  HAWAII = "Hawaii" # UTC -10:00
  ALASKA = "Alaska" # UTC -09:00
  PACIFIC = "Pacific Time (US & Canada)" # UTC -08:00
  MOUNTAIN = "Mountain Time (US & Canada)" # UTC -07:00
  CENTRAL = "Central Time (US & Canada)" # UTC -06:00
  EASTERN = "Eastern Time (US & Canada)" # UTC -05:00

  def self.all
    [
      AllowedTimeZones::HAWAII,
      AllowedTimeZones::ALASKA,
      AllowedTimeZones::PACIFIC,
      AllowedTimeZones::MOUNTAIN,
      AllowedTimeZones::CENTRAL,
      AllowedTimeZones::EASTERN
    ]
  end
end
