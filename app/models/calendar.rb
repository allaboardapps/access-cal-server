class Calendar < ActiveRecord::Base
  validates :name, presence: true
  validates :time_zone, presence: true

  has_many :calendar_users
  has_many :events
  has_many :users, through: :calendar_users

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }

  def archive
    update(archived: true)
  end

  def unarchive
    update(archived: false)
  end
end
