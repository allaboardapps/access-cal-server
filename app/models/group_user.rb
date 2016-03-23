class GroupUser < ActiveRecord::Base
  validates :group_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true

  belongs_to :group
  belongs_to :user

  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
end
