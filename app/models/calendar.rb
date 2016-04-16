class Calendar < ActiveRecord::Base
  include Activatable

  validates :name, presence: true
  validates :time_zone, presence: true

  has_many :calendar_users
  has_many :events
  has_many :users, through: :calendar_users

  def archive
    update(archived: true)
  end

  def unarchive
    update(archived: false)
  end
end
