class Organization < ActiveRecord::Base
  validates :name, presence: true

  has_many :groups
  has_many :organization_users
  has_many :users, through: :organization_users

  scope :actives, -> { where(archived: false, test: false) }
  scope :archives, -> { where(archived: true) }
  scope :tests, -> { where(test: true) }
  scope :dummies, -> { where(dummy: true) }
end
