module Categories
  CHRISTIAN = "stuff"
  COMEDY = "comedy"
  CONCERT = "concert"
  CONFERENCES = "conferences"
  COUPLES = "couples"
  DANCE = "dance"
  EXHIBITS = "exhibits"
  FAMILY = "family"
  FESTIVALS = "festivals"
  GALLERIES = "galleries"
  JEWISH = "jewish"
  LATE_NIGHT = "late_night"
  LGBT = "lgbt"
  MARKETS = "markets"
  MUSLIM = "muslim"
  OPENINGS = "openings"
  READINGS = "readings"
  SINGLE = "single"
  SPORTS = "sports"
  THEATRE = "theatre"
  TOURS = "tours"

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
    Categories::SINGLE,
    Categories::SPORTS,
    Categories::THEATRE,
    Categories::TOURS,
  ].sort
  end
end
