class Calendar < ActiveRecord::Base
  validates :name, presence: true
  validates :time_zone, presence: true

  has_many :calendar_users
  has_many :users, through: :calendar_users

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
  scope :dummy, -> { where(dummy: true) }

  def archive
    update(archived: true)
  end

  def unarchive
    update(archived: false)
  end
end
