class CalendarUser < ActiveRecord::Base
  validates :calendar_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true

  belongs_to :calendar
  belongs_to :user

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }
end
