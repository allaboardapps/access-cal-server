class FavoritesReport < ActiveRecord::Base
  # self.table_name = "favorites_report"
  # after_initialize :readonly!

  # def self.presented_columns
  #   [
  #     :id
  #   ]
  # end

  # def self.filters
  #   [
  #     ReportFilterTypes::EVENTS,
  #     ReportFilterTypes::USERS
  #   ]
  # end

  # def self.rebuild!
  #   ActiveRecord::Base.connection.execute(build_sql)
  # end

  # def self.refresh!
  #   connection.execute("REFRESH MATERIALIZED VIEW #{table_name} WITH DATA")
  # end

  def self.build_sql
    "DROP MATERIALIZED VIEW IF EXISTS #{table_name};
      CREATE MATERIALIZED VIEW #{table_name} AS
        SELECT * FROM events"
  end
end
