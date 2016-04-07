module Categories
  CHRISTIAN = "stuff".freeze
  COMEDY = "comedy".freeze
  CONCERT = "concert".freeze
  CONFERENCES = "conferences".freeze
  COUPLES = "couples".freeze
  DANCE = "dance".freeze
  EXHIBITS = "exhibits".freeze
  FAMILY = "family".freeze
  FESTIVALS = "festivals".freeze
  GALLERIES = "galleries".freeze
  JEWISH = "jewish".freeze
  LATE_NIGHT = "late_night".freeze
  LGBT = "lgbt".freeze
  MARKETS = "markets".freeze
  MUSLIM = "muslim".freeze
  OPENINGS = "openings".freeze
  READINGS = "readings".freeze
  SINGLES = "singles".freeze
  SPORTS = "sports".freeze
  THEATRE = "theatre".freeze
  TOURS = "tours".freeze

  def self.all
  [
    Categories::CHRISTIAN,
    Categories::COMEDY,
    Categories::CONCERT,
    Categories::CONFERENCES,
    Categories::COUPLES,
    Categories::DANCE,
    Categories::EXHIBITS,
    Categories::FAMILY,
    Categories::FESTIVALS,
    Categories::GALLERIES,
    Categories::JEWISH,
    Categories::LATE_NIGHT,
    Categories::LGBT,
    Categories::MARKETS,
    Categories::MUSLIM,
    Categories::OPENINGS,
    Categories::READINGS,
    Categories::SINGLES,
    Categories::SPORTS,
    Categories::THEATRE,
    Categories::TOURS
  ].sort
  end
end
