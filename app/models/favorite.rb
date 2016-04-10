class Favorite < ActiveRecord::Base
  validates :user_id, presence: true
  validates :event_id, presence: true

  belongs_to :user
  belongs_to :event

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }
end
