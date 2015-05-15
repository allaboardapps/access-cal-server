class InitialSetup < ActiveRecord::Migration
  def change
    create_table "events", force: true do |t|
      t.string "name"
      t.string "abbreviation"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end
  end
end
