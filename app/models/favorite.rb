class Favorite < ActiveRecord::Base
  validates :user_id, presence: true
  validates :event_id, presence: true

  belongs_to :user
  belongs_to :event

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
end
