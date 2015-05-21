class FavoritesReport < ActiveRecord::Base
  # self.table_name = "favorites_report"
  # after_initialize :readonly!

  # def self.refresh!
  #   connection.execute("REFRESH MATERIALIZED VIEW #{table_name} WITH DATA")
  # end
end
