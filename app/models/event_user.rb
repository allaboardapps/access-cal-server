class EventUser < ActiveRecord::Base
  validates :event_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true

  belongs_to :event
  belongs_to :user

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }
end
