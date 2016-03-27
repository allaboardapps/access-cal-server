class AddUserProfile < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :twitter_username, :string
  end
end
