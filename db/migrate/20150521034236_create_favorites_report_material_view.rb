class CreateFavoritesReportMaterialView < ActiveRecord::Migration
  # def up
  #   execute <<-SQL
  #   DROP MATERIALIZED VIEW IF EXISTS favorites_report;
  #   CREATE MATERIALIZED VIEW favorites_report AS
  #   SELECT
  #     u.first_name As first_name,
  #     u.last_name As last_name,
  #     u.email As email,
  #     u.roles[1] As role,
  #     e.name As event_name
  #   FROM favorites fa
  #   INNER JOIN users u ON u.id = fa.user_id
  #   INNER JOIN events e ON e.id = fa.event_id
  #   SQL
  # end

  # def down
  #   execute <<-SQL
  #     DROP MATERIALIZED VIEW IF EXISTS favorites_report
  #   SQL
  # end
end
